import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../bloc/creator_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../../../utils/theme/app_colors.dart';
import '../../../../../../core/constants/const_data.dart';
import '../../../../../../utils/theme/responsive_size.dart';
import 'package:reminder/core/constants/enums/remind_type.dart';
import '../../../../../../utils/extension/string_extension.dart';
import '../../../../../../core/UI/widgets/simple_app_button.dart';
import 'package:reminder/appearance/calendar/data/models/types/interval_remind.dart';

class IntervalTypeCard extends StatelessWidget {
  const IntervalTypeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: white,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: borderWidth.w,
          color: context.borderColor.withOpacity(0.08),
        ),
        borderRadius: BorderRadius.circular(buttonborderRadVal.r),
      ),

      child: BlocBuilder<CreatorBloc, CreatorState>(
        builder: (context, state) {
          // log("STATE  ${state.remind.type}");

          return InkWell(
            onTap: () {},
            overlayColor: WidgetStateProperty.all(
              context.secondaryColor.withOpacity(0.04),
            ),
            borderRadius: BorderRadius.circular(buttonborderRadVal.r),
            child: Container(
              width: appSize.width,
              padding: EdgeInsets.symmetric(
                vertical: verticalPadVal,
                horizontal: paddingVal,
              ).scaled,
              child: Column(
                spacing: spacingVal,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('interval'.tr, style: context.titleTextStyle),
                            Text(
                              'interval_subtitle'.tr,
                              style: context.subStyle,
                            ),
                          ],
                        ),
                      ),
                      CupertinoSwitch(
                        activeColor: context.primaryColor,
                        value: state.remind.type == RemindType.interval,
                        onChanged: (val) => context.read<CreatorBloc>().add(
                          CreatorEvent.updateData(
                            data: val ? intervalModel : defaultModel,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (state.remind.type == RemindType.interval)
                    IntervalItems(remind: state.remind as IntervalRemindModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class IntervalItems extends StatelessWidget {
  const IntervalItems({super.key, required this.remind});
  final IntervalRemindModel remind;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacingVal,
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 0, color: context.secondaryColor),
        Row(
          spacing: spacingVal,
          children: [
            SimpleAppButton(
              text: 'every_x_hour'.tr,
              height: 30,
              // width: 50,
              color: !remind.isHourly
                  ? context.primaryColor
                  : context.secondaryColor,
              textColor: white,
              borderRadius: iteamCardborderRadVal,
              padding: EdgeInsets.symmetric(horizontal: 14).scaled,
              style: context.subTitleTextStyle.copyWith(
                color: white,
                fontSize: 11.sp,
              ),
              onTap: () => context.read<CreatorBloc>().add(
                CreatorEvent.updateData(data: remind.copyWith(isHourly: true)),
              ),
            ),

            SimpleAppButton(
              text: 'every_x_day'.tr,
              height: 30,
              // width: 50,
              color: remind.isHourly
                  ? context.primaryColor
                  : context.secondaryColor,
              textColor: white,
              borderRadius: iteamCardborderRadVal,
              padding: EdgeInsets.symmetric(horizontal: 14).scaled,
              style: context.subTitleTextStyle.copyWith(
                color: white,
                fontSize: 11.sp,
              ),
              onTap: () => context.read<CreatorBloc>().add(
                CreatorEvent.updateData(
                  data: remind.copyWith(isHourly: false, interval: 3),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text('remind_every'.tr, style: context.subStyle),
            const Spacer(),
            SimpleAppButton(
              text: remind.interval.toString(),
              onTap: () {},
              height: 26,
              width: 26,
              color: context.primaryColor,
              textColor: white,
              borderRadius: 8,
              padding: EdgeInsets.all(3).scaled,
              margin: EdgeInsets.only(right: 8).scaled,
              style: context.subTitleTextStyle.copyWith(
                color: white,
                fontSize: 11.sp,
              ),
            ),
            Text(
              (remind.isHourly ? 'hour' : 'day').tr,
              style: context.subStyle,
            ),
          ],
        ),
      ],
    );
  }
}
