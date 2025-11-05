import 'dart:io';
import 'package:reminder/core/constants/const_data.dart';

import 'app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
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
        primary: kprimaryColor,
        secondary: green,
        error: kprimaryColor,
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
        selectedItemColor: kprimaryColor,
        unselectedItemColor: lightGrey,
        selectedIconTheme: IconThemeData(color: kprimaryColor),
        showUnselectedLabels: true,
      ),
      brightness: Brightness.light,
      tabBarTheme: TabBarThemeData(indicatorColor: kprimaryColor),
    );
  }
}

//const values
const double paddingVal = 16;
double bottomPadVal = Platform.isAndroid ? 14 : 28;
double topShowModalPadVal = Platform.isAndroid ? 60 : 100;
double safeBottomPaddingVal = Platform.isAndroid ? 20 : 0;
