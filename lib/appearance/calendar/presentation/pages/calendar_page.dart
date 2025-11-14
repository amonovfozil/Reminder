import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import '../../../../core/constants/const_data.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';
import '../widgets/cutom_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgraundStyle(
      title: 'Calendar',
      // headBody: NowRemindCard(),
      // bodyColor: white,
      headTopPosetionVal: 150,
      headBody: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(32),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomCalendar(
          primaryColor: context.primaryColor,
          todayColor: context.secondaryColor,
          initialDate: DateTime.now(),
          minDate: DateTime.now().subtract(const Duration(days: 7)),
          maxDate: DateTime.now().add(const Duration(days: 60)),
          onDateSelected: (date) {
            // Tanlangan sanani bu yerda BLoC yoki boshqa logikaga uzat
            debugPrint('Selected: $date');
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: appSize.height * 0.4,
        width: appSize.width,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          spacing: spacingVal,
          children: [SizedBox(height: bottomHeightVal, width: appSize.width)],
        ),
      ),
    );
  }
}
