import 'dart:io';

import 'package:flutter/material.dart';

//Navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//Fonts
//Popins fonst
const String poppins = 'Poppins';
// const String poppinsMedium = 'Poppins-Medium';
// const String poppinsItalic = 'Poppins-Italic';
// const String poppinsBold = 'Poppins-Bold';

//Roboto fonst
const String roboto = 'Roboto';
// const String robotoMedium = 'Roboto-Medium';
// const String robotoItalic = 'Roboto-Italic';
// const String robotoBold = 'Roboto-Bold';

//Border Radius val
const double borderRadVal = 30;
const double buttonBorderRadVal = 20;
const double buttonHeightVal = 20;
const double borderWidth = 1;

//Padding Values
const double spacingVal = 16;
const double marginVal = 16;
const double verticalPadVal = 14;
const double horizantPadVal = 24;
const double paddingVal = 16;
double bottomPadVal = Platform.isAndroid ? 16 : 28;
const double bottomHeightVal = 90;

Size get appSize => MediaQuery.of(navigatorKey.currentContext!).size;
//const values
