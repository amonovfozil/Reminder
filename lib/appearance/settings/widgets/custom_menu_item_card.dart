import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class CustomMenuItemCard extends StatelessWidget {
  final String title;
  final double height;
  final double? width;
  final Widget? suffix;
  final Widget prefix;
  final Widget bottomWidget;
  final String subtitle;
  final Color? splashColor;
  final double borderRadius;
  final double spaceTitle;
  final bool isActive;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function()? onTap;

  const CustomMenuItemCard({
    super.key,
    this.width,
    this.height = 60,
    this.splashColor,
    this.subtitle = "",
    required this.title,
    this.isActive = false,
    this.spaceTitle = spacingVal,
    this.borderRadius = borderRadVal,
    this.suffix,
    this.prefix = const SizedBox(),
    this.margin = const EdgeInsets.symmetric(horizontal: marginVal),
    this.padding = const EdgeInsets.symmetric(
      horizontal: horizantPadVal,
      vertical: verticalPadVal,
    ),
    this.bottomWidget = const SizedBox(),

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin.scaled,
      child: Material(
        elevation: 1,
        color: isActive ? context.secondaryColor : white,
        borderOnForeground: false,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: borderWidth.w,
            color: context.borderColor.withOpacity(0.08),
          ),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),

        child: InkWell(
          onTap: onTap,
          overlayColor: WidgetStateProperty.all(
            splashColor ?? context.secondaryColor.withOpacity(0.04),
          ),
          borderRadius: BorderRadius.circular(borderRadius.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: height.h,
                width: width != null ? width!.w : appSize.width,
                padding: padding.scaled,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    prefix,
                    SizedBox(width: spaceTitle.h),
                    Expanded(
                      child: Column(
                        // spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: context.subTitleTextStyle.copyWith(
                              color: isActive ? white : context.primaryColor,
                            ),
                          ),
                          if (subtitle.isNotEmpty)
                            Text(
                              subtitle,
                              style: context.subStyle.copyWith(
                                color: isActive
                                    ? white
                                    : context.secondaryColor,
                              ),
                            ),
                        ],
                      ),
                    ),

                    suffix ??
                        Icon(
                          CupertinoIcons.chevron_forward,
                          size: 28.h,
                          color: isActive ? white : context.primaryColor,
                        ),
                  ],
                ),
              ),
              bottomWidget,
            ],
          ),
        ),
      ),
    );
  }
}
