import 'package:flutter/material.dart';
import '../widgets/now_remind_card.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/core/UI/widgets/custom_card.dart';
import '../../../../core/UI/widgets/custom_card_button.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomBackgraundStyle(
      title: 'Reminder',
      bodyColor: white,
      headBody: NowRemindCard(),
      body: SingleChildScrollView(
        child: Column(
          spacing: spacingVal.h,
          children: [
            SizedBox(height: 50.h),
            CustomCardButton(
              title: "Interview",
              subtitle: '03 June, 2024  07:00PM',
              suffix: ImageIcon(
                AssetImage('assets/images/home/users.png'),
                color: context.primaryColor,
                size: 32.w,
              ),
              onTap: () {},
            ),
            CustomCard(
              title: "Birthday",
              subtitle: '03 June, 2024  07:00PM',
              suffix: ImageIcon(
                AssetImage('assets/images/home/calendar_edit.png'),
                color: context.primaryColor,
                size: 32.w,
              ),
            ),
            CustomCard(
              title: "Meeting",
              subtitle: '03 June, 2024  07:00PM',
              suffix: ImageIcon(
                AssetImage('assets/images/home/emails.png'),
                color: context.primaryColor,
                size: 32.w,
              ),
            ),
            CustomCard(
              title: "Checkup",
              subtitle: '03 June, 2024  07:00PM',
              suffix: ImageIcon(
                AssetImage('assets/images/home/docUser.png'),
                color: context.primaryColor,
                size: 32.w,
              ),
            ),
            CustomCard(
              title: "Shopping",
              subtitle: '03 June, 2024  07:00PM',
              suffix: ImageIcon(
                AssetImage('assets/images/home/bag.png'),
                color: context.primaryColor,
                size: 32.w,
              ),
            ),

            SizedBox(height: bottomHeightVal.h),
          ],
        ),
      ),
    );
  }
}
