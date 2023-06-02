import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/home/offline_view/offline_pokemon_page.dart';
import 'package:pokemon/home/online_view/online_pokemon_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasInternet = true;
  late StreamSubscription<InternetConnectionStatus> _subscription;
  late Box box;

  @override
  void initState()  {
    startMonitoringInternetConnection();
    super.initState();
  }

  void startMonitoringInternetConnection() {
    _subscription = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      setState(() {
        hasInternet = status == InternetConnectionStatus.connected;
      });
    });
  }

  Box offlineBox = Hive.box('hive');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorConst.kWhiteColor,
      body: hasInternet
          ? onlinePokemonPage(context: context, hasInternet: hasInternet)
          : offlineBox.isNotEmpty
              ? offlinePokemonPage(context: context, hasInternet: hasInternet)
              : Center(
                  child: Text("Please connect internet:"),
                ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
