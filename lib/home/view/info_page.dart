import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/home/offline_view/offline_pokemon_info_page.dart';
import 'package:pokemon/home/online_view/online_pokemon_info_page.dart';

class InfoPage extends StatefulWidget {
  int index;
  bool hasInternet;
  InfoPage({super.key, required this.index, required this.hasInternet});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late StreamSubscription<InternetConnectionStatus> _subscription;

  @override
  void initState() {
    startMonitoringInternetConnection();
    super.initState();
  }

  void startMonitoringInternetConnection() {
    _subscription = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      setState(() {
        widget.hasInternet = status == InternetConnectionStatus.connected;
       
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    

    return Scaffold(
      backgroundColor: AppColorConst.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColorConst.kbackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Pokemon Info",
          style: TextStyle(color: AppColorConst.kWhiteColor),
        ),
      ),
      body: widget.hasInternet
          ? onlinePokemonInfo(index: widget.index)
          : offlinePokemonInfoPage(
              index: widget.index,
            ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
