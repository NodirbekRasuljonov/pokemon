import 'package:flutter/material.dart';
import 'package:pokemon/home/view/home_page.dart';
import 'package:pokemon/home/view/info_page.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings s) {
    var args = s.arguments;
    switch (s.name) {
      case "/info":
        return MaterialPageRoute(
          builder: (context) {
            args as List;
            return InfoPage(index: args[0],hasInternet: args[1], );
          },
        );
      case "/home":
        return MaterialPageRoute(builder: (context) {
          return HomePage();
        });
    }
  }
}
