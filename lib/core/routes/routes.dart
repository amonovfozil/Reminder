import 'package:flutter/material.dart';
import 'package:reminder/appearance/settings/pages/settings_page.dart';
import 'package:reminder/appearance/home/presentation/pages/home_page.dart';
import 'package:reminder/appearance/home/presentation/pages/main_page.dart';
import 'package:reminder/appearance/settings/pages/parties/language_page.dart';
import 'package:reminder/appearance/settings/pages/parties/abaut_app_page.dart';
import 'package:reminder/appearance/settings/pages/parties/notificatios_page.dart';
import 'package:reminder/appearance/settings/pages/parties/display_theme_page.dart';

class AppRouter {
  static const String mainPage = '/main_page';
  static const String homePage = '/home_page';
  static const String settingPage = '/setting_page';
  static const String displayThemePage = '/display_theme_page';
  static const String languagePage = '/language_page';
  static const String notificationsPage = '/notifications_page';
  static const String abautAppPage = '/abaut_app_page';

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
      case languagePage:
        return MaterialPageRoute(builder: (ctx) => const LanguagePage());
      case notificationsPage:
        return MaterialPageRoute(builder: (ctx) => const NotificationsPage());
      case abautAppPage:
        return MaterialPageRoute(builder: (ctx) => const AbautAppPage());
      default:
        return MaterialPageRoute(
          builder: (ctx) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
