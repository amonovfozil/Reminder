import 'dart:math';
import 'package:flutter/widgets.dart';
import '../../core/constants/const_data.dart';

class ResponsiveSize {
  static Size get _screenSize => appSize;

  static double width(num value) => (value / designWidth) * _screenSize.width;

  static double height(num value) =>
      (value / designHeight) * _screenSize.height;

  static double radius(num value) => min(width(value), height(value));

  static double font(num value) {
    final double scale = min(
      _screenSize.width / designWidth,
      _screenSize.height / designHeight,
    );
    return value * scale;
  }

  static EdgeInsets padding({
    num left = 0,
    num right = 0,
    num top = 0,
    num bottom = 0,
  }) => EdgeInsets.only(
    left: width(left),
    right: width(right),
    top: height(top),
    bottom: height(bottom),
  );
}

extension ResponsiveNum on num {
  double get w => ResponsiveSize.width(this);
  double get h => ResponsiveSize.height(this);
  double get r => ResponsiveSize.radius(this);
  double get sp => ResponsiveSize.font(this);
}

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
}

extension ResponsiveEdgeInsets on EdgeInsets {
  EdgeInsets get scaled => EdgeInsets.only(
    left: left.w,
    right: right.w,
    top: top.h,
    bottom: bottom.h,
  );
}
