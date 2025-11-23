import 'package:flutter/material.dart';

// const Color kprimaryColor = Color(0xffEA3C47);

const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF283344);
const Color orange = Color(0xFFFC5007);
const Color orangeAccent = Color(0xFFFF773E);
const Color green = Color(0xFF81B73C);
const Color darkBlue = Color(0xFF343434);

const Color lightGrey = Color(0xFF8E97A7);
const Color cardColor = Color(0xffffffff);
const Color borderColor = Color(0xffCDD4E0);

extension AppColor on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get secondaryColor => Theme.of(this).secondaryHeaderColor;
  Color get scaffoldColor => white;
  Color get cardColor => Theme.of(this).primaryColor;
  Color get borderColor => Theme.of(this).hoverColor;
}
