import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/hive/hive_pokemon/hive_pokemon_model.dart';
import 'package:pokemon/hive/hive_pokemon_info/hive_pokemon_info.dart';
import 'package:pokemon/home/cubit/home_cubit.dart';
import 'package:pokemon/routes/app_routes.dart';

void main() async {
  await Hive.initFlutter();
  var box=await Hive.openBox("hive");
  Hive.registerAdapter(HivePokemonModelAdapter());
  Hive.registerAdapter(ResultsAdapter());
  Hive.registerAdapter(HivePokemonInfoAdapter());


  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageCubit(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        AppRoute route = AppRoute();
        return MaterialApp(
          onGenerateRoute: route.onGenerateRoute,
          initialRoute: "/home",
          debugShowCheckedModeBanner: false,
          title: 'Pokemon',
          theme: ThemeData.light(),
        );
      },
    );
  }
}
