import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/home/cubit/home_cubit.dart';
import 'package:pokemon/home/state/home_page_state.dart';
import 'package:pokemon/model/pokemon_info_model.dart';

BlocConsumer<HomePageCubit, HomePageState> onlinePokemonInfo(
    {required int index}) {
  return BlocConsumer<HomePageCubit, HomePageState>(
    listener: (context, state) {},
    builder: (context, state) {
      return FutureBuilder<PokemonInfoModel>(
        future: context.read<HomePageCubit>().getInfoPokemon(
              index: index,
            ),
        builder: (context, AsyncSnapshot<PokemonInfoModel> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColorConst.kbackgroundColor,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            PokemonInfoModel pokemonInfo = snapshot.data!;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 350.h,
                    width: 400.w,
                    child: Stack(
                      children: [
                        nameId(pokemonInfo: pokemonInfo, index: index),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        details(
                                            title: "Height",
                                            value:
                                                pokemonInfo.height.toString()),
                                        details(
                                            title: "Weight",
                                            value:
                                                pokemonInfo.weight.toString()),
                                        details(
                                            title: "Category",
                                            value: pokemonInfo
                                                .types![0].type!.name
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        image(pokemonInfo),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      );
    },
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

Positioned nameId({required PokemonInfoModel pokemonInfo, required int index}) {
  return Positioned(
    top: 80.h,
    left: 0.w,
    right: 0.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          pokemonInfo.id! <= 9
              ? "#00${pokemonInfo.id.toString()}"
              : "#0${pokemonInfo.id.toString()}",
          style: TextStyle(
            color: AppColorConst.kbackgroundColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          "${pokemonInfo.name![0].toUpperCase()}${pokemonInfo.name!.substring(1)}",
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

Positioned image(PokemonInfoModel pokemonInfo) {
  return Positioned(
    left: 25.w,
    right: 25.w,
    top: 25.h,
    child: SizedBox(
      height: 220.h,
      width: 289.w,
      child: CachedNetworkImage(
        imageUrl: pokemonInfo.sprites!.frontDefault.toString(),
        fit: BoxFit.contain,
      ),
    ),
  );
}
