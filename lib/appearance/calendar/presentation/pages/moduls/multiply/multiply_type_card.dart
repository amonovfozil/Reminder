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
import 'package:reminder/appearance/calendar/data/models/types/multiple_remind.dart';

class MultiplyTypeCard extends StatelessWidget {
  const MultiplyTypeCard({super.key});

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
                      CupertinoSwitch(
                        activeColor: context.primaryColor,
                        value: state.remind.type == RemindType.multiple,
                        onChanged: (val) => context.read<CreatorBloc>().add(
                          CreatorEvent.updateData(
                            data: val ? multipleRemindModel : defaultModel,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (state.remind.type == RemindType.multiple)
                    MultipleItems(remind: state.remind as MultipleRemindModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MultipleItems extends StatelessWidget {
  const MultipleItems({super.key, required this.remind});
  final MultipleRemindModel remind;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacingVal,
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 0, color: context.secondaryColor),

        Row(
          children: [
            Text('intakes'.tr, style: context.subStyle),
            const Spacer(),
            SimpleAppButton(
              text: remind.amount.toString(),
              onTap: () {},
              height: 26,
              width: 26,
              color: context.primaryColor,
              textColor: white,
              borderRadius: 8,
              padding: EdgeInsets.all(3).scaled,
              margin: EdgeInsets.only(right: 5).scaled,
              style: context.subTitleTextStyle.copyWith(
                color: white,
                fontSize: 11.sp,
              ),
            ),
            Text('times_daily'.tr.replaceAll('X', ''), style: context.subStyle),
          ],
        ),
      ],
    );
  }
}
