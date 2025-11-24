import 'package:reminder/core/helpers/formatter.dart';

import '../../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../../core/constants/const_data.dart';
import '../../../../../utils/theme/responsive_size.dart';
import '../../../../../utils/extension/string_extension.dart';
import '../../../../../core/UI/widgets/simple_app_button.dart';
import 'package:reminder/appearance/calendar/data/models/types/interval_remind.dart';

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
    return Card(
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
        child: Column(
          // spacing: spacingVal,
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
                      DateTime.now(),
                      atribut: ' ',
                    ).capitalizeWords,
                    splashColor: Colors.transparent,
                    height: 35.w / 1.h,
                    // width: 100,
                    bordercolor: borderColor,
                    color: !widget.remind.isHourly
                        ? context.primaryColor
                        : Colors.transparent,
                    borderRadius: 10.r,
                    // borderRadius: iteamCardborderRadVal,
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingVal,
                    ).scaled,
                    style: context.subTitleTextStyle.copyWith(
                      color: !widget.remind.isHourly
                          ? white
                          : context.primaryColor,
                      fontSize: 12.sp,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Column(
              children: widget.remind.times
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
                            // vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SimpleAppButton(
                                text: Formatter.dayMonthBy(DateTime.now()),
                                splashColor: Colors.transparent,
                                height: 35.w / 1.h,
                                // width: 100,
                                bordercolor: borderColor,
                                color: !widget.remind.isHourly
                                    ? context.primaryColor
                                    : Colors.transparent,
                                borderRadius: 10.r,
                                // borderRadius: iteamCardborderRadVal,
                                padding: EdgeInsets.symmetric(
                                  horizontal: paddingVal,
                                ).scaled,
                                style: context.subTitleTextStyle.copyWith(
                                  color: !widget.remind.isHourly
                                      ? white
                                      : context.primaryColor,
                                  fontSize: 12.sp,
                                ),
                                onTap: () {},
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.remind.times.remove(time);
                                  context.read<CreatorBloc>().add(
                                    CreatorEvent.updateData(
                                      data: widget.remind.copyWith(
                                        times: widget.remind.times,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(CupertinoIcons.delete),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            Container(
              padding: EdgeInsets.only(left: horizantPadVal),
              child: Divider(height: 0, color: context.borderColor),
            ),
            GestureDetector(
              onTap: () {
                List<DateTime> times = widget.remind.times;
                times.add(DateTime.now());
                context.read<CreatorBloc>().add(
                  CreatorEvent.updateData(
                    data: widget.remind.copyWith(times: times),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                padding: EdgeInsets.only(left: horizantPadVal),
                child: Row(
                  children: [
                    Icon(Icons.add_circle),
                    Text('Add Remind time'.tr, style: context.titleTextStyle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
