import 'package:flutter/material.dart';
import '../../../core/UI/widgets/custom_card_button.dart';
import '../../../core/constants/const_data.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../home/presentation/widgets/back_card_appearance.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.scaffoldColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackGraundFont(),
          Positioned(
            top: -10,
            left: 0,
            right: 10,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  actions: [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.settings, color: white, size: 26),
                    // ),
                  ],
                ),
                Text("Reminder".toUpperCase(), style: context.headerTextStyle),
              ],
            ),
          ),

          Container(
            height: appSize.height - 270,
            color: white,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              elevation: 1,
              color: white,
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
              child: Column(
                spacing: spacingVal,
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  CustomCardButton(
                    title: "Interview",
                    subtitle: '03 June, 2024  07:00PM',
                    suffix: ImageIcon(
                      AssetImage('assets/images/today/users.png'),
                      color: context.primaryColor,
                      size: 32,
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
          // Positioned(top: 175, left: 0, right: 0, child: NowRemindCard()),
        ],
      ),
    );
    ;
  }
}
