import 'package:flutter/material.dart';
import '../widgets/backgraund_font.dart';
import '../../../../core/constants/const_data.dart';
import 'package:reminder/utils/theme/text_styles.dart';

class CustomBackgraundStyle extends StatelessWidget {
  final String title;
  final AppBar? appbar;
  final Widget? headBody;
  final Widget? body;
  final Color bodyColor;
  final Color scaffoldColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final double headTopPosetionVal;
  const CustomBackgraundStyle({
    super.key,
    required this.title,
    this.body,
    this.headBody,
    this.bodyColor = Colors.transparent,
    this.scaffoldColor = Colors.transparent,
    this.appbar,
    this.bottomNavigationBar,
    this.headTopPosetionVal = 175,
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
            top: -20,
            left: 0,
            right: 10,
            child: Column(
              children: [
                appbar ?? AppBar(backgroundColor: Colors.transparent),
                Text(title.toUpperCase(), style: context.headerTextStyle),
              ],
            ),
          ),
          Container(
            height: appSize.height - 270,
            color: bodyColor,
            child: Column(children: [Expanded(child: body ?? SizedBox())]),
          ),
          Positioned(
            top: headTopPosetionVal,
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
