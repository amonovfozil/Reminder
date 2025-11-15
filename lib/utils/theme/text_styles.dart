import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

extension Txt on BuildContext {
  TextStyle get headerTextStyle => TextStyle(
    fontSize: 20.sp,
    height: 1.2,
    color: white,
    fontFamily: Theme.of(this).textTheme.bodyMedium?.fontFamily,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
  );

  TextStyle get titleTextStyle => TextStyle(
    fontSize: 16.sp,
    height: 1.2,
    color: primaryColor,
    fontFamily: Theme.of(this).textTheme.bodyMedium?.fontFamily,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
  );
  TextStyle get subTitleTextStyle => TextStyle(
    fontSize: 14.sp,
    height: 1.2,
    color: primaryColor,
    fontFamily: Theme.of(this).textTheme.bodyMedium?.fontFamily,
    fontWeight: FontWeight.w900,
    decoration: TextDecoration.none,
  );

  TextStyle get subStyle => TextStyle(
    fontSize: 13.sp,
    height: 1,
    color: secondaryColor,
    fontFamily: Theme.of(this).textTheme.bodyMedium?.fontFamily,
    decoration: TextDecoration.none,
  );
}
