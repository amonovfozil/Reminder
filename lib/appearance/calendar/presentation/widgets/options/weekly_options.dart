import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/appearance/calendar/presentation/bloc/creator_bloc.dart';
import '../../../../../utils/theme/app_colors.dart';
import '../../../data/models/types/weekly_remind.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../../core/constants/const_data.dart';
import '../../../../../utils/theme/responsive_size.dart';
import '../../../../../utils/extension/string_extension.dart';

class WeeklyOptions extends StatefulWidget {
  const WeeklyOptions({super.key, required this.remind});
  final WeeklyRemindModel remind;

  @override
  State<WeeklyOptions> createState() => _WeeklyOptionsState();
}

class _WeeklyOptionsState extends State<WeeklyOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacingVal,
      children: [
        Card(
          color: white.withOpacity(0.90),
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

          child: Container(
            width: appSize.width,
            padding: EdgeInsets.symmetric(
              vertical: paddingVal,
              horizontal: horizantPadVal,
            ),
            child: Column(
              spacing: spacingVal,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 3,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('weekly'.tr, style: context.titleTextStyle),
                          Text('weekly_subtitle'.tr, style: context.subStyle),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 0, color: context.secondaryColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekDays
                      .map(
                        (day) => GestureDetector(
                          onTap: () {
                            List<int> days = widget.remind.days;
                            int index = weekDays.indexOf(day);
                            if (days.contains(index)) {
                              days.remove(index);
                            } else {
                              days.add(index);
                            }
                            context.read<CreatorBloc>().add(
                              CreatorEvent.updateData(
                                data: widget.remind.copyWith(days: days),
                              ),
                            );
                          },
                          child: Container(
                            height: 55.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color:
                                  widget.remind.days.contains(
                                    weekDays.indexOf(day),
                                  )
                                  ? context.primaryColor
                                  : white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: context.borderColor,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              day.tr,
                              style: context.subTitleTextStyle.copyWith(
                                color:
                                    widget.remind.days.contains(
                                      weekDays.indexOf(day),
                                    )
                                    ? white
                                    : context.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
