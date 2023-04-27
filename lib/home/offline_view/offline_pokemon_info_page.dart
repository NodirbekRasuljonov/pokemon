import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/hive/hive_pokemon_info/hive_pokemon_info.dart';

Padding offlinePokemonInfoPage({required int index}) {
  Box offlineBox = Hive.box("hive");
  HivePokemonInfo offlinePokemonInfo =
      offlineBox.get("offlinePokemonInfo${index + 1}");
  // return Padding(
  //   padding: EdgeInsets.all(30.h),
  //   child: Text(offlinePokemonInfo.id),
  // );
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
                pokemonInfo: offlinePokemonInfo,
              ),
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
                                  value: offlinePokemonInfo.height),
                              details(
                                  title: "Weight",
                                  value: offlinePokemonInfo.weight),
                              details(
                                  title: "Category",
                                  value: offlinePokemonInfo.category),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              image(pokemonInfo: offlinePokemonInfo),
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

Positioned nameId({required HivePokemonInfo pokemonInfo}) {
  return Positioned(
    top: 80.h,
    left: 0.w,
    right: 0.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          int.parse(pokemonInfo.id) <= 9
              ? "#00${pokemonInfo.id.toString()}"
              : "#0${pokemonInfo.id.toString()}",
          style: TextStyle(
            color: AppColorConst.kbackgroundColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          "${pokemonInfo.name[0].toUpperCase()}${pokemonInfo.name.substring(1)}",
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

Positioned image({required HivePokemonInfo pokemonInfo}) {
  return Positioned(
    left: 100.w,
    right: 100.w,
    top: 100.h,
    child: Container(
      height: 130.h,
      width: 100.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          image: const DecorationImage(
            image: AssetImage(
              "assets/images/default.png",
            ),
            fit: BoxFit.cover
          )),
    ),
  );
}
