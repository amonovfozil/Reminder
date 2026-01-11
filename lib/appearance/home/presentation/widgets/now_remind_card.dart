import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reminder/core/helpers/helper.dart';
import '../../../remind/data/models/models.dart';
import '../../../../core/constants/const_data.dart';
import 'package:reminder/core/helpers/formatter.dart';
import '../../../../core/UI/widgets/custom_card.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import 'package:reminder/utils/extension/string_extension.dart';
import 'package:reminder/core/UI/widgets/simple_app_button.dart';

class NowRemindCard extends StatelessWidget {
  const NowRemindCard({super.key});

  @override
  Widget build(BuildContext context) {
    RemindModel? firstRemind = Helper.sortRemindByDate;
    DateTime timeNow = Helper.sortRemindTime ?? DateTime.now();
    log("message DATE $timeNow");
    return CustomCard(
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      title: firstRemind?.title ?? '',
      subtitle:
          '⏰ ${firstRemind?.type?.name.capitalizeFirst} ${Formatter.timeFormat(timeNow)} ',
      suffix: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 2.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50.h,
                width: 35.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      context.secondaryColor.withOpacity(0.7),
                      white.withOpacity(0.8),
                      white,
                      white,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    (timeNow.day > 10 ? (timeNow.day / 10) : 0)
                        .toInt()
                        .toString(),
                    style: context.headerTextStyle.copyWith(fontSize: 35.sp),
                  ),
                ),
              ),
              Container(
                height: 50.h,
                width: 35.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      context.secondaryColor.withOpacity(0.7),
                      white.withOpacity(1),
                      white,
                      white,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    // '0',
                    (timeNow.day % 10).toString(),
                    style: context.headerTextStyle.copyWith(fontSize: 35.sp),
                  ),
                ),
              ),
            ],
          ),
          Text(
            Formatter.monthYear(timeNow).capitalizeWords,
            style: context.subStyle.copyWith(fontSize: 12.sp, height: 1.5),
          ),
        ],
      ),
      prefix: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          spacing: 6.w,
          children: [
            SimpleAppButton(
              text: 'View',
              height: buttonHeightVal,
              onTap: () {},
              style: context.subStyle.copyWith(color: white),
            ),
            SimpleAppButton(
              text: 'Edit',
              onTap: () {},
              height: buttonHeightVal,
              color: Colors.transparent,
              textColor: context.primaryColor,
              style: context.subStyle.copyWith(color: context.primaryColor),
            ),
            SimpleAppButton(
              text: 'Delete',

              onTap: () {},
              height: buttonHeightVal,
              color: Colors.transparent,
              textColor: context.primaryColor,
              style: context.subStyle.copyWith(color: context.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
