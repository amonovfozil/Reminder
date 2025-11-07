import 'dart:io';
import 'package:flutter/material.dart';

//Navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Locales
const String ru = 'ru';
const String uz = 'uz';
const String en = 'en';

//Fonts
const String poppins = 'Poppins';
const String roboto = 'Roboto';
const String montserrat = 'Montserrat';
const String playfair = 'Playfair';
const String ptSans = 'PT_Sans_Narrow';
const String ubuntu = 'Ubuntu';

//Sounds
const String custom = 'custom';
const String ringTon = 'RingTon';
const String radial = 'Radial';
const String breaking = 'Breaking';
const String challet = 'Challet';
const String melody = 'Melody';

//Border Radius val
const double borderRadVal = 30;
const double iteamCardBorderRadVal = 20;
const double buttonBorderRadVal = 20;
const double buttonHeightVal = 20;
const double borderWidth = 1;
const double cardIconSize = 32;

//Padding Values
const double spacingVal = 16;
const double marginVal = 16;
const double cardMarginVal = 32;
const double verticalPadVal = 14;
const double horizantPadVal = 24;
const double paddingVal = 16;
const double bottomHeightVal = 90;
double bottomPadVal = Platform.isAndroid ? 16 : 28;

Size get appSize => MediaQuery.of(navigatorKey.currentContext!).size;
//const values
