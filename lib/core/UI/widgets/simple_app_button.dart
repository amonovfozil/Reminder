import 'package:flutter/material.dart';
import '../../../utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/core/constants/const_data.dart';

class SimpleAppButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color textColor;
  final bool isLoad;
  final double borderRadius;
  final double? width;
  final double? height;
  final TextStyle? style;
  final Color? hoverColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Function()? onTap;
  final Color bordercolor;
  final Color? splashColor;

  const SimpleAppButton({
    super.key,
    required this.text,
    this.onTap,
    this.isLoad = false,
    this.borderRadius = buttonBorderRadVal,
    this.width,
    this.height = buttonHeightVal,
    this.margin = const EdgeInsets.symmetric(horizontal: 0),
    this.padding = const EdgeInsets.symmetric(horizontal: paddingVal),
    this.style,
    this.hoverColor,
    this.color,
    this.splashColor,
    this.textColor = white,
    this.bordercolor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Material(
        color: color ?? context.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(width: borderWidth, color: bordercolor),
        ),

        child: InkWell(
          onTap: onTap,
          overlayColor: WidgetStateProperty.all(
            splashColor ?? context.secondaryColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: height,
            width: width,
            padding: padding,
            alignment: Alignment.center,
            child: Text(
              text,
              style: context.subStyle.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
