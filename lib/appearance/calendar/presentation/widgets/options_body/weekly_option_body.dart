import '../../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/theme/app_colors.dart';
import '../../../data/models/types/weekly_remind.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../../core/constants/const_data.dart';
import '../../../../../utils/theme/responsive_size.dart';
import '../../../../../utils/extension/string_extension.dart';

class WeeklyOptionBody extends StatefulWidget {
  const WeeklyOptionBody({super.key, required this.remind});
  final WeeklyRemindModel remind;

  @override
  State<WeeklyOptionBody> createState() => _WeeklyOptionBodyState();
}

class _WeeklyOptionBodyState extends State<WeeklyOptionBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacingVal,
      children: [
        Divider(height: 0, color: context.secondaryColor),
        Container(
          width: appSize.width,
          padding: EdgeInsets.only(
            bottom: paddingVal,
            right: horizantPadVal,
            left: horizantPadVal,
          ),
          child: Column(
            spacing: spacingVal,
            mainAxisSize: MainAxisSize.min,
            children: [
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
      ],
    );
  }
}
