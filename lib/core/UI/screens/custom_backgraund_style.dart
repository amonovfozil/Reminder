import 'package:flutter/material.dart';
import '../widgets/backgraund_font.dart';
import '../../../../core/constants/const_data.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class CustomBackgraundStyle extends StatelessWidget {
  final String title;
  // final AppBar? appbar;
  final Widget? headBody;
  final Widget? body;
  final Color bodyColor;
  final Color scaffoldColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? leadingAppbar;
  final double? toolbarHeight;
  final double? leadingWidth;
  final double headTopPosetionVal;
  const CustomBackgraundStyle({
    super.key,
    required this.title,
    this.body,
    this.headBody,
    this.bodyColor = Colors.transparent,
    this.scaffoldColor = Colors.transparent,
    this.leadingAppbar,
    this.bottomNavigationBar,
    this.headTopPosetionVal = 125,
    this.toolbarHeight,
    this.leadingWidth,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackgraundFont(color: scaffoldColor),
          Positioned(
            // top: (-10).h,
            // left: 0.w,
            // right: 10.w,
            child: Column(
              children: [
                // appbar ??
                AppBar(
                  toolbarHeight: toolbarHeight,
                  leadingWidth: leadingWidth,
                  leading: leadingAppbar,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    title.toUpperCase(),
                    style: context.headerTextStyle,
                  ),
                ),
                // Text(title.toUpperCase(), style: context.headerTextStyle),
              ],
            ),
          ),
          Container(
            height: appSize.height - 220.h,
            color: bodyColor,
            child: body ?? SizedBox(),
          ),
          Positioned(
            top: headTopPosetionVal.h,
            left: 0,
            right: 0,
            child: headBody ?? SizedBox(),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
    );
  }
}
