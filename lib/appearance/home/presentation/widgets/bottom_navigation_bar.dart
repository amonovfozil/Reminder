import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class CustomBottomNavigationBarItem {
  final String? title;
  final String iconPath;
  final Function? function;

  CustomBottomNavigationBarItem({
    this.title,
    required this.iconPath,
    this.function,
  });
}

List<CustomBottomNavigationBarItem> menu = [
  CustomBottomNavigationBarItem(iconPath: "assets/images/home/home.png"),
  CustomBottomNavigationBarItem(iconPath: "assets/images/home/calendar.png"),
  CustomBottomNavigationBarItem(iconPath: "assets/images/home/settings.png"),
];

class CutomBottomNavigationBar extends StatelessWidget {
  const CutomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        width: appSize.width - 75.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadVal.r),
          color: context.secondaryColor,
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorAnimation: TabIndicatorAnimation.elastic,
          padding: EdgeInsets.all(5.w),
          labelPadding: EdgeInsets.zero,
          indicatorWeight: 0,
          dividerHeight: 0,
          indicator: BoxDecoration(
            color: context.primaryColor,
            borderRadius: BorderRadius.circular(borderRadVal.r),
          ),
          overlayColor: WidgetStatePropertyAll(context.secondaryColor),
          tabs: menu
              .mapWithIndex(
                (item, index) => Tab(
                  child: ImageIcon(
                    AssetImage(item.iconPath),
                    color: white,
                    size: 28.w,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
