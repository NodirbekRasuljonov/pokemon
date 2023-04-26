import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/hive/hive_pokemon/hive_pokemon_model.dart';
import 'package:pokemon/hive/hive_pokemon_info/hive_pokemon_info.dart';

Scaffold offlinePokemonPage(BuildContext context) {
  Box offlineBox = Hive.box("hive");

  List<HivePokemonInfo> offlineData = offlineBox.get("offlinePokemon");

  return Scaffold(
    body: CustomScrollView(
      slivers: [
        appBar(),
        pokemons(context: context, offlineData: offlineData),
      ],
    ),
  );
}

SliverGrid pokemons(
    {required BuildContext context,
    required List<HivePokemonInfo> offlineData}) {
  return SliverGrid.builder(
    itemCount: 20,
    itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/info", arguments: index + 1);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          height: 60.h,
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColorConst.kbackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                index < 9 ? "#00${index + 1}" : "#0${index + 1}",
                style: TextStyle(
                  color: AppColorConst.kWhiteColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "${offlineData[index].name[0].toUpperCase()}${offlineData[index].name.substring(1)}",
                style: TextStyle(
                  color: AppColorConst.kWhiteColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        )),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
  );
}

SliverAppBar appBar() {
  return SliverAppBar(
    backgroundColor: AppColorConst.kWhiteColor,
    elevation: 0.0,
    floating: true,
    expandedHeight: 200.h,
    flexibleSpace: FlexibleSpaceBar(
      collapseMode: CollapseMode.parallax,
      background: Image.asset("assets/images/pokemon.png"),
    ),
  );
}
