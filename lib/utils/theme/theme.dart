import 'app_colors.dart';
import 'page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:reminder/core/constants/const_data.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      primaryColor: orange,
      secondaryHeaderColor: orangeAccent,
      cardColor: cardColor,
      hoverColor: borderColor,
      canvasColor: const Color(0xFFCDD4E0),
      scaffoldBackgroundColor: white,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: orangeAccent,
        foregroundColor: orangeAccent,
        surfaceTintColor: orangeAccent,
        scrolledUnderElevation: 0,
      ),
      iconTheme: const IconThemeData(color: lightGrey),
      colorScheme: const ColorScheme.light(
        primary: orange,
        secondary: green,
        error: orangeAccent,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      fontFamily: poppins,
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(overlayColor: WidgetStatePropertyAll(green)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: orange,
        unselectedItemColor: lightGrey,
        selectedIconTheme: IconThemeData(color: orange),
        showUnselectedLabels: true,
      ),
      brightness: Brightness.light,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CustomPageTransitionBuilder(),
          TargetPlatform.iOS: CustomPageTransitionBuilder(),
        },
      ),
      tabBarTheme: TabBarThemeData(indicatorColor: orange),
    );
  }
}
