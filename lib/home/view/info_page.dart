import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/hive/hive_pokemon_info/hive_pokemon_info.dart';
import 'package:pokemon/home/cubit/home_cubit.dart';
import 'package:pokemon/home/offline_view/offline_pokemon_info_page.dart';
import 'package:pokemon/home/online_view/online_pokemon_info_page.dart';
import 'package:pokemon/home/state/home_page_state.dart';
import 'package:pokemon/model/pokemon_info_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class InfoPage extends StatefulWidget {
  int index;
  InfoPage({super.key, required this.index,});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

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

  @override
  Widget build(BuildContext context) {
    Box offlineBox = Hive.box("hive");
    // HivePokemonInfo offlinePokemonInfo =
    //     offlineBox.getAt(1);
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
        body: hasInternet
            // ? onlinePokemonInfo(index: widget.index)
            ? Center(
                child: Text("Online Page:$hasInternet"),
              )
            : Center(
                child: Text("Offline Page $hasInternet"),
              )
        // : offlinePokemonInfoPage(
        //     pokemonInfo: offlinePokemonInfo[widget.index],
        //   ),
        );
  }
}
