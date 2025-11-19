import 'package:flutter/cupertino.dart';
import '../widgets/cutom_calendar.dart';
import '../widgets/remind_types_modal.dart';
import '../../../../core/helpers/helper.dart';
import '../../../../core/constants/const_data.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import 'package:reminder/core/UI/widgets/simple_app_button.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';
import 'package:reminder/appearance/calendar/data/models/remind_model.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<RemindModel> models = [];
  @override
  Widget build(BuildContext context) {
    return CustomBackgraundStyle(
      title: 'Calendar',
      headTopPosetionVal: 105.h / 1.w,
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
                debugPrint('Selected: $date');
              },
            ),
          ),
          SimpleAppButton(
            text: 'creat',
            color: white,
            textColor: context.primaryColor,
            margin: EdgeInsets.symmetric(
              horizontal: marginVal.w,
              vertical: 5.h,
            ),
            onTap: () => Helper.showBottomModel(
              ctx: context,
              body: RemindTypesModal(),
              title: "Select Remind type",
            ),
          ),

          Container(
            height: appSize.height * 0.6.h,
            margin: EdgeInsets.only(
              // top: 16.h,
              left: marginVal.w,
              right: marginVal.w,
            ),

            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            ),
            child: models.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(bottom: 200.h),
                    child: Center(
                      child: Icon(CupertinoIcons.folder, size: 45.w / 1.h),
                    ),
                  )
                : Column(mainAxisSize: MainAxisSize.min, children: []),
          ),
        ],
      ),
    );
  }
}
