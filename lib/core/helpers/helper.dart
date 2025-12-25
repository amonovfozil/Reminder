import 'package:flutter/material.dart';
import '../constants/const_data.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/theme/responsive_size.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/core/UI/widgets/simple_app_button.dart';

class Helper {
  static Future<void> showBottomModel({
    required BuildContext ctx,
    Function()? onConfirm,
    required Widget body,
    String title = '',
  }) async {
    await showCupertinoModalPopup(
      context: ctx,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: white.withOpacity(0.75),
          border: Border.all(
            width: borderWidth,
            color: context.borderColor.withOpacity(0.08),
          ),
          borderRadius: BorderRadius.circular(borderRadVal.r),
        ),
        child: Column(
          spacing: spacingVal,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: title.isEmpty ? 0 : 16),
              child: Text(
                title,
                style: context.subTitleTextStyle.copyWith(
                  color: context.primaryColor,
                ),
              ),
            ),
            body,
            Visibility(
              visible: onConfirm != null,
              child: SimpleAppButton(
                text: 'Confirm',
                borderRadius: borderRadVal.r,
                margin: const EdgeInsets.symmetric(
                  horizontal: cardMarginVal,
                  vertical: 10,
                ),
                onTap: () => onConfirm,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showDateTimeModal(
    BuildContext cxt, {
    required Function(DateTime) onTap,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.time,
    DateTime? initial,
    String? title,
    DateTime? minDate,
  }) {
    DateTime val = initial ?? DateTime.now();
    showModalBottomSheet(
      context: cxt,
      builder: (context) => Container(
        height: 320,
        decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadiusDirectional.vertical(
            top: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.only(top: verticalPadVal, bottom: bottomPadVal),
        child: Column(
          spacing: spacingVal,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  title,
                  style: context.subTitleTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      applyThemeToAll: true,
                      textTheme: CupertinoTextThemeData(
                        textStyle: cxt.subStyle,
                      ),
                      brightness: Theme.of(context).brightness,
                    ),
                    child: CupertinoDatePicker(
                      backgroundColor: white,
                      minimumDate: minDate,
                      initialDateTime: val,
                      mode: mode,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newDate) {
                        // print("dattime  $newDate");
                        val = newDate;
                      },
                    ),
                  ),
                  Text(":", style: context.subTitleTextStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizantPadVal),
              child: SimpleAppButton(text: "confirm", onTap: () => onTap(val)),
            ),
          ],
        ),
      ),
    );
  }
}
