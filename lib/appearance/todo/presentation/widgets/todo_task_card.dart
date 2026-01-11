import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class TodoTaskCard extends StatelessWidget {
  final String title;
  final String timeLabel;
  final String note;
  final Color statusColor;
  final bool isDone;
  final bool isEditable;
  final String? iconPath;
  final String typeLabel;
  final VoidCallback? onToggle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TodoTaskCard({
    super.key,
    required this.title,
    required this.timeLabel,
    required this.note,
    required this.statusColor,
    required this.isDone,
    required this.isEditable,
    this.iconPath,
    this.typeLabel = '',
    this.onToggle,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: context.borderColor.withOpacity(0.08)),
      ),
      child: InkWell(
        onTap: isEditable ? onEdit : null,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (iconPath != null)
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: ImageIcon(
                    AssetImage(iconPath!),
                    size: 18.w,
                    color: statusColor,
                  ),
                )
              else
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: context.secondaryColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.task_alt, size: 18.w, color: lightGrey),
                ),
              SizedBox(width: 8.w),
              Container(
                width: 4.w,
                height: 42.h,
                margin: EdgeInsets.only(top: 4.h),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: context.subTitleTextStyle),
                    SizedBox(height: 6.h),
                    if (note.isNotEmpty)
                      Text(note, style: context.subStyle)
                    else if (typeLabel.isNotEmpty)
                      Text(
                        typeLabel,
                        style: context.subStyle.copyWith(
                          color: darkBlue.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(timeLabel, style: context.subStyle),
                  IconButton(
                    onPressed: isEditable ? onToggle : null,
                    icon: Icon(
                      isDone
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isDone ? statusColor : lightGrey,
                      size: 22.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
