import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../core/UI/widgets/backgraund_font.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class CustomFontCard extends StatelessWidget {
  final Color color;
  final Color secondaryColor;
  final String title;
  final Function(Color?, Color?) onSelect;
  const CustomFontCard({
    super.key,
    required this.color,
    required this.secondaryColor,
    required this.title,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        GestureDetector(
          onTap: () => onSelect(color, secondaryColor),
          child: Container(
            height: 120.h,
            width: 95.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: context.primaryColor == color ? 6 : borderWidth,
                strokeAlign: context.primaryColor == color
                    ? BorderSide.strokeAlignOutside
                    : BorderSide.strokeAlignInside,
                color: color,
                // color: context.primaryColor == color ? Colors.black : color,
              ),
            ),
            child: BackgraundFont(color: color, percentSize: 0.75),
          ),
        ),
        Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.circle, color: color, size: 20),
            Text(
              title,
              style: context.subTitleTextStyle.copyWith(color: color),
            ),
          ],
        ),
      ],
    );
  }
}
