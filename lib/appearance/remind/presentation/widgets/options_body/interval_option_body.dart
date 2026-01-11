// import '../note_status_widget.dart';
import '../../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/helper.dart';
import '../../../../../core/helpers/formatter.dart';
import '../../../../../utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../../core/constants/const_data.dart';
import '../../../../../utils/theme/responsive_size.dart';
import '../../../data/models/types/interval_remind.dart';
import '../../../../../utils/extension/string_extension.dart';
import '../../../../../core/UI/widgets/simple_app_button.dart';

class IntervalOptionBody extends StatefulWidget {
  const IntervalOptionBody({super.key, required this.remind});
  final IntervalRemindModel remind;

  @override
  State<IntervalOptionBody> createState() => _IntervalOptionBodyState();
}

class _IntervalOptionBodyState extends State<IntervalOptionBody> {
  List timeInterval = [0.5, 1, 1.5, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  List dayInterval = List.generate(90 - 2 + 1, (index) => (2 + index));

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacingVal,
      children: [
        Card(
          color: white.withOpacity(1),
          margin: const EdgeInsets.symmetric(horizontal: horizantPadVal).scaled,
          elevation: 1,
          borderOnForeground: false,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: borderWidth,
              color: context.borderColor.withOpacity(0.08),
            ),
            borderRadius: BorderRadius.circular(borderRadVal.r),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: verticalPadVal),
            child: widget.remind.isHourly
                ? HoursInterval(remind: widget.remind)
                : DaysInterval(remind: widget.remind),
          ),
        ),
        // RemindNoteStatusWidget(remind: widget.remind),
      ],
    );
  }
}

class HoursInterval extends StatelessWidget {
  const HoursInterval({super.key, required this.remind});
  final IntervalRemindModel remind;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizantPadVal),
          child: Row(
            spacing: spacingVal,
            children: [
              Expanded(
                child: Text('starting_at'.tr, style: context.titleTextStyle),
              ),

              SimpleAppButton(
                text: Formatter.timeFormat(remind.startDate),
                splashColor: Colors.transparent,
                height: 35.w / 1.h,
                bordercolor: borderColor,
                color: !remind.isHourly
                    ? context.primaryColor
                    : Colors.transparent,
                borderRadius: 10.r,
                padding: EdgeInsets.symmetric(horizontal: paddingVal).scaled,
                style: context.subTitleTextStyle.copyWith(
                  color: !remind.isHourly ? white : context.primaryColor,
                  fontSize: 12.sp,
                ),
                onTap: () => Helper.showDateTimeModal(
                  // title: 'starting_at'.tr,
                  initial: remind.startDate,
                  context,
                  onTap: (tm) {
                    context.read<CreatorBloc>().add(
                      CreatorEvent.updateData(
                        data: remind.copyWith(startDate: tm),
                      ),
                    );
                    navigatorKey.currentState?.maybePop();
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: horizantPadVal),
          child: Divider(height: 20, color: context.borderColor),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizantPadVal),
          child: Row(
            spacing: spacingVal,
            children: [
              Expanded(
                child: Text('ending_at'.tr, style: context.titleTextStyle),
              ),

              SimpleAppButton(
                text: Formatter.timeFormat(remind.endDate ?? DateTime.now()),
                splashColor: Colors.transparent,
                height: 35.w / 1.h,
                bordercolor: borderColor,
                color: !remind.isHourly
                    ? context.primaryColor
                    : Colors.transparent,
                borderRadius: 10.r,
                padding: EdgeInsets.symmetric(horizontal: paddingVal).scaled,
                style: context.subTitleTextStyle.copyWith(
                  color: !remind.isHourly ? white : context.primaryColor,
                  fontSize: 12.sp,
                ),
                onTap: () => Helper.showDateTimeModal(
                  // title: 'starting_at'.tr,
                  initial: remind.endDate,
                  context,
                  onTap: (tm) {
                    context.read<CreatorBloc>().add(
                      CreatorEvent.updateData(
                        data: remind.copyWith(endDate: tm),
                      ),
                    );
                    navigatorKey.currentState?.maybePop();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DaysInterval extends StatelessWidget {
  const DaysInterval({super.key, required this.remind});
  final IntervalRemindModel remind;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizantPadVal),
          child: Row(
            spacing: spacingVal,
            children: [
              Expanded(
                child: Text('start_date'.tr, style: context.titleTextStyle),
              ),

              SimpleAppButton(
                text: Formatter.dayMonthBy(
                  remind.startDate,
                  atribut: ' ',
                ).capitalizeWords,
                splashColor: Colors.transparent,
                height: 35.w / 1.h,
                // width: 100,
                bordercolor: borderColor,
                color: !remind.isHourly
                    ? context.primaryColor
                    : Colors.transparent,
                borderRadius: 10.r,
                // borderRadius: iteamCardborderRadVal,
                padding: EdgeInsets.symmetric(horizontal: paddingVal).scaled,
                style: context.subTitleTextStyle.copyWith(
                  color: !remind.isHourly ? white : context.primaryColor,
                  fontSize: 12.sp,
                ),
                onTap: () {
                  var now = DateTime.now();
                  Helper.showDateTimeModal(
                    context,
                    // title: 'starting_at'.tr,
                    initial: remind.startDate,
                    minDate: DateTime(now.year, now.month, now.day),
                    mode: CupertinoDatePickerMode.date,
                    onTap: (tm) {
                      context.read<CreatorBloc>().add(
                        CreatorEvent.updateData(
                          data: remind.copyWith(startDate: tm),
                        ),
                      );
                      navigatorKey.currentState?.maybePop();
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: remind.times
                .map(
                  (time) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: horizantPadVal),
                        child: Divider(height: 0, color: context.borderColor),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizantPadVal,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SimpleAppButton(
                              text: Formatter.timeFormat(time),
                              splashColor: Colors.transparent,
                              height: 35.w / 1.h,
                              // width: 100,
                              bordercolor: borderColor,
                              color: !remind.isHourly
                                  ? context.primaryColor
                                  : Colors.transparent,
                              borderRadius: 10.r,
                              // borderRadius: iteamCardborderRadVal,
                              padding: EdgeInsets.symmetric(
                                horizontal: paddingVal,
                              ).scaled,
                              style: context.subTitleTextStyle.copyWith(
                                color: !remind.isHourly
                                    ? white
                                    : context.primaryColor,
                                fontSize: 12.sp,
                              ),
                              onTap: () => Helper.showDateTimeModal(
                                title: 'Select Time',
                                initial: time,
                                context,
                                onTap: (tm) {
                                  final updatedTimes = List<DateTime>.from(
                                    remind.times,
                                  );
                                  final index = updatedTimes.indexOf(time);
                                  if (index != -1) {
                                    updatedTimes[index] = tm;
                                  }
                                  context.read<CreatorBloc>().add(
                                    CreatorEvent.updateData(
                                      data: remind.copyWith(
                                        times: updatedTimes,
                                      ),
                                    ),
                                  );
                                  navigatorKey.currentState?.maybePop();
                                },
                              ),
                            ),
                            Visibility(
                              visible: remind.times.length != 1,
                              child: GestureDetector(
                                onTap: () {
                                  remind.times.remove(time);
                                  context.read<CreatorBloc>().add(
                                    CreatorEvent.updateData(
                                      data: remind.copyWith(
                                        times: remind.times,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(CupertinoIcons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: horizantPadVal, bottom: 12),
          child: Divider(height: 0, color: context.borderColor),
        ),
        GestureDetector(
          onTap: () {
            List<DateTime> times = remind.times;
            times.add(times.last.copyWith(hour: times.last.hour + 2));
            context.read<CreatorBloc>().add(
              CreatorEvent.updateData(data: remind.copyWith(times: times)),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            padding: EdgeInsets.only(left: horizantPadVal),
            child: Row(
              children: [
                Icon(Icons.add_circle),
                Text(' Add Remind time'.tr, style: context.titleTextStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
