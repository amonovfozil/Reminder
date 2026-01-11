import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class TodoStatusRow extends StatelessWidget {
  final int total;
  final int doneOnTime;
  final int late;
  final int notDone;
  final int pending;
  final Color doneColor;
  final Color lateColor;
  final Color notDoneColor;
  final Color pendingColor;

  const TodoStatusRow({
    super.key,
    required this.total,
    required this.doneOnTime,
    required this.late,
    required this.notDone,
    required this.pending,
    required this.doneColor,
    required this.lateColor,
    required this.notDoneColor,
    required this.pendingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: context.borderColor.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildItem('Jami', total, context.primaryColor),
          _buildItem('Yashil', doneOnTime, doneColor),
          _buildItem('Sariq', late, lateColor),
          _buildItem('Qizil', notDone, notDoneColor),
          // _buildItem('Kutilmoqda', pending, pendingColor),
        ],
      ),
    );
  }

  Widget _buildItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: darkBlue.withOpacity(0.8),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 14.sp,
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
