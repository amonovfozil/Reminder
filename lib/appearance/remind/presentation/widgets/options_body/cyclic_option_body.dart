import '../../../../../core/helpers/formatter.dart';
import '../../../../../core/helpers/helper.dart';
import '../../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/theme/app_colors.dart';
import '../../../data/models/types/cyclic_remind.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../../core/constants/const_data.dart';
import '../../../../../utils/theme/responsive_size.dart';
import '../../../../../utils/extension/string_extension.dart';
import '../../../../../core/UI/widgets/simple_app_button.dart';

class CyclicOptionBody extends StatefulWidget {
  const CyclicOptionBody({super.key, required this.remind});
  final CyclicRemindModel remind;

  @override
  State<CyclicOptionBody> createState() => _CyclicOptionBodyState();
}

class _CyclicOptionBodyState extends State<CyclicOptionBody> {
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
            child: CyclicForm(remind: widget.remind),
          ),
        ),
        // RemindNoteStatusWidget(remind: widget.remind),
      ],
    );
  }
}

class CyclicForm extends StatelessWidget {
  const CyclicForm({super.key, required this.remind});
  final CyclicRemindModel remind;

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
                color: context.primaryColor,
                borderRadius: 10.r,
                // borderRadius: iteamCardborderRadVal,
                padding: EdgeInsets.symmetric(horizontal: paddingVal).scaled,
                style: context.subTitleTextStyle.copyWith(
                  color: white,
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
                              color: context.primaryColor,
                              borderRadius: 10.r,
                              // borderRadius: iteamCardborderRadVal,
                              padding: EdgeInsets.symmetric(
                                horizontal: paddingVal,
                              ).scaled,
                              style: context.subTitleTextStyle.copyWith(
                                color: white,
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
