import 'package:flutter/material.dart';
import '../../../utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

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
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function()? onTap;
  final Color bordercolor;
  final Color? splashColor;

  const SimpleAppButton({
    super.key,
    required this.text,
    this.onTap,
    this.isLoad = false,
    this.borderRadius = buttonborderRadVal,
    this.width,
    this.height = 60,
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
      padding: margin.scaled,
      child: Material(
        color: color ?? context.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          side: BorderSide(width: borderWidth.w, color: bordercolor),
        ),

        child: InkWell(
          onTap: onTap,
          overlayColor: WidgetStateProperty.all(
            splashColor ?? context.secondaryColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius.r),
          child: Container(
            height: height?.h,
            width: width?.w,
            padding: padding.scaled,
            alignment: Alignment.center,
            child: Text(
              text,
              style:
                  style ?? context.subTitleTextStyle.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
