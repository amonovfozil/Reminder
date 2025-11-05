import 'package:flutter/material.dart';
import '../widgets/now_remind_card.dart';
import '../widgets/back_card_appearance.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/core/UI/widgets/custom_card.dart';
import '../../../../core/UI/widgets/custom_card_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.scaffoldColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BacgroundCardStyle(title: 'Reminder'),

          // Positioned(
          //   top: -10,
          //   left: 0,
          //   right: 10,
          //   child: Column(
          //     children: [
          //       AppBar(
          //         backgroundColor: Colors.transparent,
          //         actions: [
          //           // IconButton(
          //           //   onPressed: () {},
          //           //   icon: Icon(Icons.settings, color: white, size: 26),
          //           // ),
          //         ],
          //       ),
          //       Text("Reminder".toUpperCase(), style: context.headerTextStyle),
          //     ],
          //   ),
          // ),
          Container(
            height: appSize.height - 270,
            color: white,
            child: SingleChildScrollView(
              child: Column(
                spacing: spacingVal,
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
                  CustomCard(
                    title: "Birthday",
                    subtitle: '03 June, 2024  07:00PM',
                    suffix: ImageIcon(
                      AssetImage('assets/images/today/calendar.png'),
                      color: context.primaryColor,
                      size: 32,
                    ),
                  ),
                  CustomCard(
                    title: "Meeting",
                    subtitle: '03 June, 2024  07:00PM',
                    suffix: ImageIcon(
                      AssetImage('assets/images/today/emails.png'),
                      color: context.primaryColor,
                      size: 32,
                    ),
                  ),
                  CustomCard(
                    title: "Checkup",
                    subtitle: '03 June, 2024  07:00PM',
                    suffix: ImageIcon(
                      AssetImage('assets/images/today/docUser.png'),
                      color: context.primaryColor,
                      size: 32,
                    ),
                  ),
                  CustomCard(
                    title: "Shopping",
                    subtitle: '03 June, 2024  07:00PM',
                    suffix: ImageIcon(
                      AssetImage('assets/images/today/bag.png'),
                      color: context.primaryColor,
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 90),

                  // Text('', style: context.subStyle),
                ],
              ),
            ),
          ),
          Positioned(top: 175, left: 0, right: 0, child: NowRemindCard()),
        ],
      ),
    );
  }
}
