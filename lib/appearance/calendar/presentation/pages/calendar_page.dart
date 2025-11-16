import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import '../../../../core/constants/const_data.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';
import '../widgets/cutom_calendar.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgraundStyle(
      title: 'Calendar',
      // headBody: NowRemindCard(),
      // bodyColor: white,
      // headTopPosetionVal: 110.h / 1.w,
      headBody: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(32.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: CustomCalendar(
              primaryColor: context.primaryColor,
              todayColor: context.secondaryColor,
              initialDate: DateTime.now(),
              minDate: DateTime.now().subtract(const Duration(days: 7)),
              maxDate: DateTime.now().add(const Duration(days: 360)),
              onDateSelected: (date) {
                // Tanlangan sanani bu yerda BLoC yoki boshqa logikaga uzat
                debugPrint('Selected: $date');
              },
            ),
          ),

          Container(
            height: appSize.height,
            // width: appSize.width.w,
            margin: EdgeInsets.only(
              top: 16.h,
              left: marginVal.w,
              right: marginVal.w,
            ),

            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: bottomHeightVal.h, width: appSize.width),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: ,
    );
  }
}
