import 'package:flutter/material.dart';
import '../../constants/const_data.dart';
import 'package:reminder/utils/theme/app_colors.dart';

class BackgraundFont extends StatelessWidget {
  final Color? color;
  final double percentSize;
  const BackgraundFont({super.key, this.color, this.percentSize = 1});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: appSize.height * percentSize,
          width: appSize.width * percentSize,
          color: color ?? context.primaryColor,
        ),
        Positioned(
          top: 0 * percentSize,
          left: -35 * percentSize,
          child: Container(
            height: 125 * percentSize,
            width: 138 * percentSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withOpacity(0.22),
            ),
          ),
        ),
        Positioned(
          top: 220 * percentSize,
          left: -105 * percentSize,
          child: Container(
            height: 125 * percentSize,
            width: 138 * percentSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withOpacity(0.22),
            ),
          ),
        ),
        Positioned(
          top: 95 * percentSize,
          right: -90 * percentSize,
          child: Container(
            height: 125 * percentSize,
            width: 138 * percentSize,
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
