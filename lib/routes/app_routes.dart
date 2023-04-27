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
            return InfoPage(index: args as int);
          },
        );
      case "/home":
        return MaterialPageRoute(builder: (context) {
          return HomePage();
        });
    }
  }
}
