import 'dart:io';
import 'app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData(
      primaryColor: black,
      cardColor: lightCardColor,
      hoverColor: lightBorderColor,
      canvasColor: const Color(0xFFCDD4E0),
      scaffoldBackgroundColor: lightAppBgColor,
      appBarTheme: lightAppBarTheme,
      iconTheme: const IconThemeData(color: lightGreyText),
      textTheme: lightTextTheme,
      colorScheme: const ColorScheme.light(
        onPrimary: lightAppBgColor,
        primary: kprimaryColor,
        secondary: green,
        error: kprimaryColor,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(overlayColor: WidgetStatePropertyAll(green)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightCardColor,
        selectedItemColor: kprimaryColor,
        unselectedItemColor: lightGreyText,
        selectedIconTheme: IconThemeData(color: kprimaryColor),
        showUnselectedLabels: true,
      ),
      brightness: Brightness.light,
      tabBarTheme: TabBarThemeData(indicatorColor: kprimaryColor),
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      primaryColor: white,
      scaffoldBackgroundColor: darkAppBgColor,
      cardColor: darckCardColor,
      hoverColor: darkBorderColor,
      canvasColor: const Color(0xff161D24),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(overlayColor: WidgetStatePropertyAll(green)),
      ),
      appBarTheme: darkAppBarTheme,
      iconTheme: const IconThemeData(color: kprimaryColor),
      textTheme: darkTextTheme,
      colorScheme: const ColorScheme.dark(
        onPrimary: darkAppBgColor,
        primary: kprimaryColor,
        secondary: green,
        error: kprimaryColor,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darckCardColor,
        selectedItemColor: kprimaryColor,
        unselectedItemColor: lightGreyText,
        selectedIconTheme: IconThemeData(color: kprimaryColor),
        showUnselectedLabels: true,
      ),
      brightness: Brightness.dark,
      tabBarTheme: TabBarThemeData(indicatorColor: const Color(0xFFE9EDF3)),
    );
  }
}

//Appvar theme
const lightAppBarTheme = AppBarTheme(
  centerTitle: true,
  elevation: 0,
  backgroundColor: lightAppBgColor,
  foregroundColor: lightAppBgColor,
  surfaceTintColor: lightAppBgColor,
  scrolledUnderElevation: 0,
);
const darkAppBarTheme = AppBarTheme(
  centerTitle: true,
  elevation: 0,
  backgroundColor: darkAppBgColor,
  foregroundColor: darkAppBgColor,
  surfaceTintColor: darkAppBgColor,
  scrolledUnderElevation: 0,
);

//light TextTheme
const TextTheme lightTextTheme = TextTheme(
  //title
  titleLarge: TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w700,
    fontFamily: 'sfpro',
    color: black,
    decoration: TextDecoration.none,
  ),

  titleMedium: TextStyle(
    fontSize: 13.6,
    fontWeight: FontWeight.w400,
    fontFamily: 'sfpro',
    height: 1.54,
    color: lightGreyText,
    decoration: TextDecoration.none,
  ),

  //headline
  headlineLarge: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    fontFamily: 'sfpro',
    decoration: TextDecoration.none,
    color: black,
  ),

  //body
  bodyLarge: TextStyle(
    fontSize: 13.6,
    fontWeight: FontWeight.w700,
    fontFamily: 'sfpro',
    color: black,
    decoration: TextDecoration.none,
  ),
  bodyMedium: TextStyle(
    fontSize: 13.6,
    fontWeight: FontWeight.w400,
    fontFamily: 'sfpro',
    height: 1.35,
    color: darkAppBgColor,
    decoration: TextDecoration.none,
  ),
  //label
  labelMedium: TextStyle(
    fontSize: 13.6,
    fontWeight: FontWeight.w400,
    fontFamily: 'sfpro',
    color: white,
    decoration: TextDecoration.none,
  ),

  labelSmall: TextStyle(
    color: black,
    fontSize: 20,
    fontFamily: 'pangram',
    fontWeight: FontWeight.w400,
  ),
);

//Dark TextTheme
const TextTheme darkTextTheme = TextTheme(
  //title
  titleLarge: TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w700,
    fontFamily: 'sfpro',
    color: white,
    decoration: TextDecoration.none,
  ),
  titleMedium: TextStyle(
    fontSize: 13.6,
    fontWeight: FontWeight.w400,
    fontFamily: 'sfpro',
    height: 1.54,
    color: lightGreyText,
    decoration: TextDecoration.none,
  ),
  //headline
  headlineLarge: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    fontFamily: 'sfpro',
    decoration: TextDecoration.none,
    color: white,
  ),

  //body
  bodyLarge: TextStyle(
    fontSize: 13.6,
    fontWeight: FontWeight.w700,
    fontFamily: 'sfpro',
    color: white,
    decoration: TextDecoration.none,
  ),
  bodyMedium: TextStyle(
    fontSize: 13.6,
    fontWeight: FontWeight.w400,
    fontFamily: 'sfpro',
    height: 1.35,
    color: lightAppBgColor,
    decoration: TextDecoration.none,
  ),
  //label
  labelMedium: TextStyle(
    fontSize: 13.6,
    fontWeight: FontWeight.w400,
    fontFamily: 'sfpro',
    color: black,
    decoration: TextDecoration.none,
  ),
  //for app logo
  labelSmall: TextStyle(
    color: white,
    fontSize: 20,
    fontFamily: 'pangram',
    fontWeight: FontWeight.w400,
  ),
);

//const values
const double paddingVal = 16;
double bottomPadVal = Platform.isAndroid ? 14 : 28;
double topShowModalPadVal = Platform.isAndroid ? 60 : 100;
double safeBottomPaddingVal = Platform.isAndroid ? 20 : 0;
