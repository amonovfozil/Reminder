import '../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/text_styles.dart';
import '../../../../core/constants/const_data.dart';
import '../../../../utils/theme/responsive_size.dart';
import '../../../../utils/extension/string_extension.dart';

class RemindNoteStatusWidget extends StatelessWidget {
  const RemindNoteStatusWidget({super.key, required this.remind});
  final dynamic remind;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: horizantPadVal),
                  child: Text(
                    'prominent_reminder'.tr,
                    style: context.subTitleTextStyle,
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
                        child: Text(
                          'enable_critical_alert'.tr,
                          style: context.titleTextStyle,
                        ),
                      ),

                      CupertinoSwitch(
                        activeColor: context.secondaryColor,
                        value: remind.enableAlert,
                        onChanged: (val) => context.read<CreatorBloc>().add(
                          CreatorEvent.updateData(
                            data: remind.copyWith(enableAlert: val),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: horizantPadVal,
            vertical: verticalPadVal / 2,
          ).scaled,

          child: Row(
            spacing: spacingVal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info, color: context.borderColor),
              Expanded(
                child: Text(
                  'remember_critical_alert'.tr,
                  style: context.subStyle.copyWith(color: context.borderColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
