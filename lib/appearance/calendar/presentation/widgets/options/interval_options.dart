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

class IntervalOptions extends StatefulWidget {
  const IntervalOptions({super.key, required this.remind});
  final IntervalRemindModel remind;

  @override
  State<IntervalOptions> createState() => _IntervalOptionsState();
}

class _IntervalOptionsState extends State<IntervalOptions> {
  late FixedExtentScrollController scrollController;
  List timeInterval = [0.5, 1, 1.5, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  List dayInterval = List.generate(90 - 2 + 1, (index) => (2 + index));
  @override
  void initState() {
    scrollController = FixedExtentScrollController(initialItem: 0);
    super.initState();
  }

  void _jumpToIndex(int index) {
    scrollController.animateToItem(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var intervalValues = widget.remind.isHourly ? timeInterval : dayInterval;

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
                          Text(
                            'multiple_daily'.tr,
                            style: context.titleTextStyle,
                          ),
                          Text(
                            'multiple_daily_subtitle'.tr,
                            style: context.subStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 0, color: context.secondaryColor),
                Row(
                  spacing: spacingVal,
                  children: [
                    Expanded(
                      child: SimpleAppButton(
                        text: 'every_x_hour'.tr.replaceAll(
                          'X',
                          !widget.remind.isHourly
                              ? 'X'
                              : widget.remind.interval.toStringAsFixed(
                                  widget.remind.interval ==
                                          widget.remind.interval.toInt()
                                      ? 0
                                      : 1,
                                ),
                        ),
                        height: 35.w / 1.h,
                        width: double.infinity,
                        bordercolor: borderColor,
                        color: widget.remind.isHourly
                            ? context.primaryColor
                            : Colors.transparent,
                        borderRadius: 10.r,
                        // borderRadius: iteamCardborderRadVal,
                        padding: EdgeInsets.symmetric(horizontal: 14).scaled,
                        style: context.subTitleTextStyle.copyWith(
                          color: widget.remind.isHourly
                              ? white
                              : context.primaryColor,
                          fontSize: 12.sp,
                        ),
                        onTap: () {
                          context.read<CreatorBloc>().add(
                            CreatorEvent.updateData(
                              data: widget.remind.copyWith(
                                isHourly: true,
                                interval: 0.5,
                              ),
                            ),
                          );
                          _jumpToIndex(0);
                        },
                      ),
                    ),

                    Expanded(
                      child: SimpleAppButton(
                        text: 'every_x_day'.tr.replaceAll(
                          'X',
                          widget.remind.isHourly
                              ? 'X'
                              : widget.remind.interval.toStringAsFixed(
                                  widget.remind.interval ==
                                          widget.remind.interval.toInt()
                                      ? 0
                                      : 1,
                                ),
                        ),

                        height: 35.w / 1.h,
                        width: double.infinity,
                        bordercolor: borderColor,
                        color: !widget.remind.isHourly
                            ? context.primaryColor
                            : Colors.transparent,
                        borderRadius: 10.r,
                        // borderRadius: iteamCardborderRadVal,
                        padding: EdgeInsets.symmetric(horizontal: 14).scaled,
                        style: context.subTitleTextStyle.copyWith(
                          color: !widget.remind.isHourly
                              ? white
                              : context.primaryColor,
                          fontSize: 12.sp,
                        ),
                        onTap: () {
                          context.read<CreatorBloc>().add(
                            CreatorEvent.updateData(
                              data: widget.remind.copyWith(
                                isHourly: false,
                                interval: 2,
                              ),
                            ),
                          );
                          _jumpToIndex(0);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          child: Card(
            color: white.withOpacity(0.90),
            margin: const EdgeInsets.symmetric(
              horizontal: horizantPadVal,
            ).scaled,
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
                // vertical: paddingVal,
                horizontal: horizantPadVal,
              ).scaled,
              child: SizedBox(
                height: 160.w / 1.h,
                child: CupertinoPicker(
                  itemExtent: 35,
                  scrollController: scrollController,
                  children: intervalValues
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(top: 6).scaled,
                          child: Text(
                            e.toString(),
                            textAlign: TextAlign.start,
                            style: context.titleTextStyle.copyWith(
                              // fontSize: 20,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onSelectedItemChanged: (index) =>
                      context.read<CreatorBloc>().add(
                        CreatorEvent.updateData(
                          data: widget.remind.copyWith(
                            interval: intervalValues[index].toDouble(),
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
