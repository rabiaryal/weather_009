
import 'package:flutter/material.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      // case RouteName.home:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const HomeScreen());

      // case RouteName.login:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const LoginScreen());
      

      // case RouteName.signUp:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const SignUpView());


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
