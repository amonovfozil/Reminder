import '../../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../../core/constants/const_data.dart';
import '../../../data/models/types/multiple_remind.dart';
import '../../../../../utils/theme/responsive_size.dart';
import '../../../../../utils/extension/string_extension.dart';
import '../../../../../core/UI/widgets/simple_app_button.dart';

class MultipleOptions extends StatefulWidget {
  const MultipleOptions({super.key, required this.remind});
  final MultipleRemindModel remind;

  @override
  State<MultipleOptions> createState() => _MultipleOptionsState();
}

class _MultipleOptionsState extends State<MultipleOptions> {
  List<int> intervalValues = List.generate(10 - 2 + 1, (index) => (2 + index));

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
            ).scaled,
            child: Column(
              spacing: spacingVal,
              mainAxisSize: MainAxisSize.min,
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
                  ],
                ),
                Divider(height: 0, color: context.secondaryColor),
                Row(
                  children: [
                    Text('amount_'.tr, style: context.subStyle),
                    const Spacer(),
                    SimpleAppButton(
                      text: widget.remind.amount.toString(),
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
                    Text(
                      'times_daily'.tr.replaceAll('X', ''),
                      style: context.subStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          // visible: remind.enableInterval,
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
                  children: intervalValues
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(top: 6).scaled,
                          child: Text(
                            e.toString(),
                            textAlign: TextAlign.start,
                            style: context.subTitleTextStyle.copyWith(
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
                            amount: intervalValues[index],
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
