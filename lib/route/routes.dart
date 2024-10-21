
import 'package:flutter/material.dart';

import 'package:weather_009/pages/firstpage/firstpage.dart';
import 'package:weather_009/route/route_name.dart';
import 'package:weather_009/widgets/dialog.dart';
import 'package:weather_009/pages/search/searchwidgets.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteName.first:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FirstPage());

      case RouteName.searchcountry:
        return MaterialPageRoute(
            builder: (BuildContext context) =>const  CitySearchBox());
      

      case RouteName.dialog:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SecondDialog());


      //   case RouteName.splash:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const SpalshScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No Route Defined"),
            ),
          );
        });
    }
  }
}
