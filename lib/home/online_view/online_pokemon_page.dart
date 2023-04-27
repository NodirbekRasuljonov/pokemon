import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/home/cubit/home_cubit.dart';
import 'package:pokemon/home/state/home_page_state.dart';
import 'package:pokemon/model/pokemon_model.dart';

Scaffold onlinePokemonPage(
    {required BuildContext context, required bool hasInternet}) {
  return Scaffold(
    backgroundColor: AppColorConst.kWhiteColor,
    body: CustomScrollView(
      slivers: [
        appBar(),
        pokemons(context: context, hasInternet: hasInternet),
      ],
    ),
  );
}

SliverGrid pokemons(
    {required BuildContext context, required bool hasInternet}) {
  return SliverGrid.builder(
    itemCount: 20,
    itemBuilder: (context, index) => BlocConsumer<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return FutureBuilder(
          future: 
              context.read<HomePageCubit>().getPokemon(index: index + 1),
          
          
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColorConst.kbackgroundColor,
                ),
              );
            } else if (snapshot.hasData) {
              PokemonModel data = snapshot.data;
              return GestureDetector(
                  onTap: () {
                    debugPrint(index.toString());
                    Navigator.pushNamed(
                      context,
                      "/info",
                      arguments: [index, hasInternet],
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                          index <= 9 ? "#00${index + 1}" : "#0${index + 1}",
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
                          "${data.results![index].name![0].toUpperCase()}${data.results![index].name!.substring(1)}",
                          style: TextStyle(
                            color: AppColorConst.kWhiteColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ));
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const Center(
                child: Text("SAlom"),
              );
            }
          },
        );
      },
      listener: (context, state) {},
    ),
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
