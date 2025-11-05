import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/appearance/home/presentation/bloc/home_bloc.dart';

class CustomBottomNavigationBarItem {
  final String? title;
  final IconData icon;
  final Function? function;

  CustomBottomNavigationBarItem({
    this.title,
    required this.icon,
    this.function,
  });
}

List<CustomBottomNavigationBarItem> menu = [
  CustomBottomNavigationBarItem(icon: CupertinoIcons.home),
  CustomBottomNavigationBarItem(icon: CupertinoIcons.calendar),
  CustomBottomNavigationBarItem(icon: Icons.settings),
];

class CutomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CutomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        color: context.primaryColor,

        // height: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadVal),
          // border: Border.all(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: menu
                .mapWithIndex(
                  (item, index) => InkWell(
                    onTap: () => context.read<HomeBloc>().add(
                      HomeEvent.switchScreen(index: index),
                    ),
                    borderRadius: BorderRadius.circular(borderRadVal),
                    overlayColor: WidgetStateProperty.all(
                      white.withOpacity(0.22),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? white.withOpacity(0.22)
                            : null,
                        borderRadius: BorderRadius.circular(borderRadVal),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: (appSize.width - 64) / 8.5,
                        vertical: 10,
                      ),
                      child: Icon(item.icon, color: white, size: 28),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
