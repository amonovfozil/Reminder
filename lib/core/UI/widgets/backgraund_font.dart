import 'package:flutter/material.dart';
import '../../constants/const_data.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class BackgraundFont extends StatelessWidget {
  final Color? color;
  final double percentSize;
  final bool showDecorations;

  const BackgraundFont({
    super.key,
    this.color,
    this.percentSize = 1,
    this.showDecorations = true,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowDecorations = showDecorations && color != Colors.transparent;
    return Stack(
      children: [
        Container(
          height: appSize.height * percentSize,
          width: appSize.width * percentSize,
          color: color ?? context.primaryColor,
        ),
        Visibility(
          visible: shouldShowDecorations,
          child: Positioned(
            top: (0 * percentSize).h,
            left: (-35 * percentSize).w,
            child: Container(
              height: (125 * percentSize).h,
              width: (138 * percentSize).w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: white.withOpacity(0.22),
              ),
            ),
          ),
        ),
        Visibility(
          visible: shouldShowDecorations,
          child: Positioned(
            top: (250 * percentSize).h,
            left: (-105 * percentSize).w,
            child: Container(
              height: (125 * percentSize).h,
              width: (138 * percentSize).w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: white.withOpacity(0.22),
              ),
            ),
          ),
        ),
        Visibility(
          visible: shouldShowDecorations,
          child: Positioned(
            top: (95 * percentSize).h,
            right: (-80 * percentSize).w,
            child: Container(
              height: (125 * percentSize).h,
              width: (138 * percentSize).w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: white.withOpacity(0.22),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
