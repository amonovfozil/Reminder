import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/core/constants/const_data.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        width: appSize.width - 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadVal),
          color: context.secondaryColor,
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorAnimation: TabIndicatorAnimation.elastic,
          padding: const EdgeInsets.all(5),
          labelPadding: const EdgeInsets.all(0),
          indicatorWeight: 0,
          dividerHeight: 0,
          indicator: BoxDecoration(
            color: context.primaryColor,
            borderRadius: BorderRadius.circular(borderRadVal),
          ),
          overlayColor: WidgetStatePropertyAll(context.secondaryColor),
          tabs: menu
              .mapWithIndex(
                (item, index) => Tab(
                  child: ImageIcon(
                    AssetImage(item.iconPath),
                    color: white,
                    size: 28,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
