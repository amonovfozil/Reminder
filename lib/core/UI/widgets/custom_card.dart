import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/core/constants/const_data.dart';

class CustomCard extends StatelessWidget {
  final double height;
  final double? width;
  final String title;
  final String subtitle;
  final Widget suffix;
  final Widget prefix;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const CustomCard({
    super.key,
    this.height = 75,
    this.width,
    required this.title,
    this.subtitle = "",
    this.suffix = const SizedBox(),
    this.prefix = const SizedBox(),
    this.margin = const EdgeInsets.symmetric(horizontal: marginVal),
    this.padding = const EdgeInsets.symmetric(
      horizontal: horizantPadVal,
      vertical: verticalPadVal,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: 1,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: borderWidth,
          color: context.borderColor.withOpacity(0.08),
        ),
        borderRadius: BorderRadius.circular(borderRadVal),
      ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(borderRadVal),
      //   border: Border.all(width: borderWidth, color: context.borderColor),
      // ),
      child: Container(
        height: height,
        width: width ?? appSize.width,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    // spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.subTitleTextStyle),
                      Visibility(
                        visible: subtitle.isNotEmpty,
                        child: Text(subtitle, style: context.subStyle),
                      ),
                    ],
                  ),

                  suffix,
                ],
              ),
            ),
            prefix,
          ],
        ),
      ),
    );
  }
}
