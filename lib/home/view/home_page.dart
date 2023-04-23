import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/constants/color_const.dart';
import 'package:pokemon/home/cubit/home_cubit.dart';
import 'package:pokemon/home/state/home_page_state.dart';
import 'package:pokemon/model/pokemon_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocConsumer<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return FutureBuilder<PokemonModel>(
            future: context.read<HomePageCubit>().getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator.adaptive();
              } else if (snapshot.hasData) {
                PokemonModel data = snapshot.data;
                return ListView.builder(
                  itemCount: data.results!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 25.h),
                      color: Colors.amber,
                      height: 300.h,
                      width: 190.w,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0.w,
                            right: 0.w,
                            bottom: 0.h,
                            child: Container(
                              height: 200.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                color: AppColorConst.kbackgroundColor,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              alignment: Alignment.bottomCenter,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 20.w,
                                    right: 20.w,
                                    bottom: 20.h,
                                    child: Container(
                                      height: 60.h,
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color:
                                            AppColorConst.kInfoBackgroundColor,
                                      ),
                                      child: Text(
                                        snapshot.data!.results[index].name,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("Error"),
                );
              }
            },
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: AppColorConst.kTransparentColor,
      toolbarHeight: 130.0,
      centerTitle: true,
      elevation: 0.0,
      title: Image.asset("assets/images/pokemon.png"),
    );
  }
}
