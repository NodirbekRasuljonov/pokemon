import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/home/cubit/home_cubit.dart';
import 'package:pokemon/home/offline_view/offline_pokemon_page.dart';
import 'package:pokemon/home/online_view/online_pokemon_page.dart';
import 'package:pokemon/home/state/home_page_state.dart';
import 'package:pokemon/model/pokemon_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasInternet = false;
  late StreamSubscription<InternetConnectionStatus> _subscription;

  @override
  void initState() {
    super.initState();
    startMonitoringInternetConnection();
  }

  void startMonitoringInternetConnection() {
    _subscription = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      setState(() {
        hasInternet = status == InternetConnectionStatus.connected;
        print(hasInternet);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  Box offlineBox = Hive.box("hive");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorConst.kWhiteColor,
      body: hasInternet
          ? onlinePokemonPage(context: context)
          : offlineBox.isNotEmpty
              ? offlinePokemonPage(context: context)
              :  Center(
                  child: Text("Please connect internet:$hasInternet"),
                ),
    );
  }
}
