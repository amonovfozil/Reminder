import 'package:flutter/material.dart';
import '../widgets/backgraund_font.dart';
import '../../../../core/constants/const_data.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';

class CustomBackgraundStyle extends StatelessWidget {
  final String title;
  final AppBar? appbar;
  final Widget? headBody;
  final Widget body;
  const CustomBackgraundStyle({
    super.key,
    required this.title,
    required this.body,
    this.headBody,
    this.appbar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.scaffoldColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackgraundFont(),
          Positioned(
            top: -10,
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
            color: white,
            child: Column(children: [Expanded(child: body)]),
          ),
          Positioned(
            top: 175,
            left: 0,
            right: 0,
            child: headBody ?? SizedBox(),
          ),
        ],
      ),
    );
  }
}
