import 'package:flutter/material.dart';
import '../../../../core/constants/const_data.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgraundStyle(
      title: 'Calendar',
      // headBody: NowRemindCard(),
      body: SingleChildScrollView(
        child: Column(
          spacing: spacingVal,
          children: [const SizedBox(height: bottomHeightVal)],
        ),
      ),
    );
  }
}
