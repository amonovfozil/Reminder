import 'package:flutter/material.dart';
import 'package:reminder/appearance/settings/pages/settings_page.dart';
import 'package:reminder/appearance/home/presentation/pages/home_page.dart';
import 'package:reminder/appearance/home/presentation/pages/main_page.dart';
import 'package:reminder/appearance/settings/pages/parties/display_theme_page.dart';
import '../../appearance/remind/presentation/pages/creat_remind_screen.dart';
import '../../appearance/remind/presentation/pages/select_remind_type_screen.dart';

class AppRouter {
  static const String mainPage = '/main_page';
  static const String homePage = '/home_page';
  static const String settingPage = '/setting_page';
  static const String displayThemePage = '/display_theme_page';
  static const String notificationsPage = '/notifications_page';
  static const String abautAppPage = '/abaut_app_page';
  //Remind moduls
  static const String selectRemindTypeScreen = '/select_remind_type_screen';
  static const String creatRemindScreen = '/creat_remind_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(builder: (ctx) => const MainPage());
      case homePage:
        return MaterialPageRoute(builder: (ctx) => const HomePage());
      case settingPage:
        return MaterialPageRoute(builder: (ctx) => const SettingsPage());
      case displayThemePage:
        return MaterialPageRoute(builder: (ctx) => const DisplayThemePage());
      // case notificationsPage:
      //   return MaterialPageRoute(builder: (ctx) => const NotificationsPage());

      //Remind moduls
      case selectRemindTypeScreen:
        return MaterialPageRoute(
          builder: (ctx) => const SelectRemindTypeScreen(),
        );
      case creatRemindScreen:
        return MaterialPageRoute(builder: (ctx) => const CreatRemindScreen());

      default:
        return MaterialPageRoute(
          builder: (ctx) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
