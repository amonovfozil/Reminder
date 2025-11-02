import 'package:flutter/material.dart';

class AppRouter {
  static const String homePage = '/home_page';
  static const String clockPage = '/main_page';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Main pages

      // case homePage:
      //   return MaterialPageRoute(builder: (ctx) => const HomeScreen());
      // case clockPage:
      //   return MaterialPageRoute(builder: (ctx) => const MainPage());

      default:
        return MaterialPageRoute(
          builder: (ctx) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
