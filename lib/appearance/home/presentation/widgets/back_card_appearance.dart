import 'package:flutter/material.dart';
import '../../../../core/constants/const_data.dart';
import 'package:reminder/utils/theme/app_colors.dart';

class BacgroundCardStyle extends StatelessWidget {
  final String title;
  const BacgroundCardStyle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackGraundFont(),
        Positioned(
          top: -10,
          left: 0,
          right: 10,
          child: Column(
            children: [
              AppBar(backgroundColor: Colors.transparent, actions: [
                 
                ],
              ),
              Text(title.toUpperCase(), style: context.headerTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}

extension on BuildContext {
  TextStyle? get headerTextStyle => null;
}

class BackGraundFont extends StatelessWidget {
  const BackGraundFont({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: appSize.height,
          width: double.infinity,
          color: context.primaryColor,
        ),
        Positioned(
          top: 0,
          left: -35,
          child: Container(
            height: 125,
            width: 138,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withOpacity(0.22),
            ),
          ),
        ),
        Positioned(
          top: 220,
          left: -105,
          child: Container(
            height: 125,
            width: 138,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withOpacity(0.22),
            ),
          ),
        ),
        Positioned(
          top: 95,
          right: -90,
          child: Container(
            height: 125,
            width: 138,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withOpacity(0.22),
            ),
          ),
        ),
      ],
    );
  }
}
