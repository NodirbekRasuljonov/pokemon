import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/hive/hive_pokemon_info/hive_pokemon_info.dart';

Padding offlinePokemonInfoPage({required int index}) {
  // return  Padding(padding: EdgeInsets.all(30.h),child: Text("Offline"),);
  Box offlineBox = Hive.box("hive");
  HivePokemonInfo offlinePokemonInfo =
        offlineBox.getAt(1)[index];
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    child: Column(
      children: [
        SizedBox(
          height: 350.h,
          width: 400.w,
          child: Stack(
            children: [
              nameId(
                  pokemonInfo: offlineBox.get("offlinePokemonInfo"),
                  index: index),
              Positioned(
                bottom: 0.h,
                left: 0.w,
                right: 0.w,
                child: Container(
                    height: 230.h,
                    width: 400.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: AppColorConst.kbackgroundColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 130.h,
                          left: 20.w,
                          right: 20.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              details(
                                  title: "Height",
                                  value: offlinePokemonInfo.height
                                  ),
                              details(
                                  title: "Weight",
                                  value:offlinePokemonInfo.weight),
                              details(
                                  title: "Category",
                                  value: offlinePokemonInfo.category
                                  ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              image(
                  pokemonInfo: offlineBox.get("offlinePokemonInfo"),
                  index: index),
            ],
          ),
        )
      ],
    ),
  );
}

Column details({required String title, required String value}) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
            color: AppColorConst.kWhiteColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(
        height: 10.h,
      ),
      Text(
        title == "Height"
            ? "$value m"
            : title == "Weight"
                ? "$value kg"
                : "${value[0].toUpperCase()}${value.substring(1)}",
        style: TextStyle(
          color: AppColorConst.kBlackColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

Positioned nameId(
    {required List<HivePokemonInfo> pokemonInfo, required int index}) {
  return Positioned(
    top: 80.h,
    left: 0.w,
    right: 0.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          int.parse(pokemonInfo[index].id) <= 9
              ? "#00${pokemonInfo[index].id.toString()}"
              : "#0${pokemonInfo[index].id.toString()}",
          style: TextStyle(
            color: AppColorConst.kbackgroundColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          "${pokemonInfo[index].name[0].toUpperCase()}${pokemonInfo[index].name.substring(1)}",
          style: TextStyle(
            color: AppColorConst.kBlackColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
        )
      ],
    ),
  );
}

Positioned image(
    {required List<HivePokemonInfo> pokemonInfo, required int index}) {
  return Positioned(
    left: 25.w,
    right: 25.w,
    top: 25.h,
    child: Container(
      height: 220.h,
      width: 289.w,
      child: CachedNetworkImage(
        imageUrl: pokemonInfo[index].imageUrl.toString(),
        fit: BoxFit.contain,
      ),
    ),
  );
}
