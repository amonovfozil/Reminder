import 'package:reminder/core/UI/widgets/simple_app_button.dart';

import '../../utils/theme/responsive_size.dart';
import '../constants/const_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';

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
          // color: context.primaryColor.withOpacity(0.75),
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
            // if (title.isNotEmpty)
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
                // height: 55,
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
}
