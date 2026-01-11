import 'package:flutter/material.dart';
import 'package:reminder/core/UI/widgets/custom_text_feild.dart';
import 'package:reminder/core/UI/widgets/simple_app_button.dart';
import 'package:reminder/core/helpers/formatter.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import 'package:reminder/appearance/todo/data/models/todo_task_model.dart';

class TodoTypeOption {
  final String key;
  final String label;
  final String assetPath;

  const TodoTypeOption({
    required this.key,
    required this.label,
    required this.assetPath,
  });
}

class TodoTaskEditorSheet extends StatefulWidget {
  final TodoTaskModel? task;
  final DateTime selectedDate;
  final List<TodoTypeOption> typeOptions;
  final void Function(
    String title,
    String note,
    DateTime plannedAt,
    String iconKey,
    String typeLabel,
  )
  onSave;
  final VoidCallback? onDelete;

  const TodoTaskEditorSheet({
    super.key,
    required this.selectedDate,
    required this.typeOptions,
    required this.onSave,
    this.task,
    this.onDelete,
  });

  @override
  State<TodoTaskEditorSheet> createState() => _TodoTaskEditorSheetState();
}

class _TodoTaskEditorSheetState extends State<TodoTaskEditorSheet> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _noteCtrl;
  late DateTime _plannedAt;
  String _iconKey = '';
  String _typeLabel = '';

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.task?.title ?? '');
    _noteCtrl = TextEditingController(text: widget.task?.note ?? '');
    final now = DateTime.now();
    _plannedAt =
        widget.task?.plannedAt ??
        DateTime(
          widget.selectedDate.year,
          widget.selectedDate.month,
          widget.selectedDate.day,
          now.hour,
          now.minute,
        );
    _iconKey = widget.task?.iconKey ?? '';
    _typeLabel = widget.task?.typeLabel ?? '';
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task == null ? 'Yangi reja' : 'Rejani tahrirlash',
            style: context.subTitleTextStyle,
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            controller: _titleCtrl,
            validator: (val) => (val == null || val.trim().isEmpty)
                ? 'Sarlavha kiriting'
                : null,
            labelText: 'Nomi',
            hintText: 'Bugungi ish',
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: _noteCtrl,
            validator: (_) => null,
            labelText: 'Izoh',
            hintText: 'Ixtiyoriy izoh',
            maxLines: 2,
          ),
          SizedBox(height: 12.h),
          Text('Icon/Type (ixtiyoriy)', style: context.subStyle),
          SizedBox(height: 8.h),
          _buildTypeDropdown(context),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.secondaryColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.schedule, size: 16.w),
                      SizedBox(width: 8.w),
                      Text(
                        Formatter.timeFormat(_plannedAt),
                        style: context.subStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              SimpleAppButton(
                text: 'Vaqt tanlash',
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                textColor: context.primaryColor,
                color: context.secondaryColor.withOpacity(0.08),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_plannedAt),
                  );
                  if (picked == null) return;
                  setState(() {
                    _plannedAt = DateTime(
                      widget.selectedDate.year,
                      widget.selectedDate.month,
                      widget.selectedDate.day,
                      picked.hour,
                      picked.minute,
                    );
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SimpleAppButton(
            text: widget.task == null ? 'Qo\'shish' : 'Saqlash',
            onTap: () {
              final title = _titleCtrl.text.trim();
              if (title.isEmpty) return;
              widget.onSave(
                title,
                _noteCtrl.text.trim(),
                _plannedAt,
                _iconKey,
                _typeLabel,
              );
            },
          ),
          if (widget.onDelete != null) ...[
            SizedBox(height: 8.h),
            SimpleAppButton(
              text: 'O\'chirish',
              color: white,
              textColor: Colors.redAccent,
              bordercolor: Colors.redAccent,
              onTap: widget.onDelete,
            ),
          ],
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildTypeDropdown(BuildContext context) {
    final value = _iconKey.isEmpty ? 'none' : _iconKey;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: context.secondaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.borderColor.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: Icon(Icons.expand_more, color: lightGrey),
          selectedItemBuilder: (context) {
            final items = [
              (label: 'Tanlanmagan', assetPath: '', isNone: true),
              ...widget.typeOptions.map(
                (option) => (
                  label: option.label,
                  assetPath: option.assetPath,
                  isNone: false,
                ),
              ),
            ];

            return items
                .map(
                  (item) => Row(
                    children: [
                      Container(
                        width: 26.w,
                        height: 26.w,
                        decoration: BoxDecoration(
                          color: item.isNone
                              ? context.secondaryColor.withOpacity(0.08)
                              : context.primaryColor.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: item.isNone
                            ? Icon(
                                Icons.remove_circle_outline,
                                size: 14.w,
                                color: darkBlue.withOpacity(0.7),
                              )
                            : ImageIcon(
                                AssetImage(item.assetPath),
                                size: 14.w,
                                color: context.primaryColor,
                              ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        item.label,
                        style: context.subStyle.copyWith(
                          color: item.isNone
                              ? darkBlue.withOpacity(0.7)
                              : context.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
                .toList();
          },
          items: [
            DropdownMenuItem(
              value: 'none',
              child: Row(
                children: [
                  Icon(
                    Icons.remove_circle_outline,
                    size: 16.w,
                    color: darkBlue.withOpacity(0.7),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Tanlanmagan',
                    style: context.subStyle.copyWith(
                      color: darkBlue.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            ...widget.typeOptions.map(
              (option) => DropdownMenuItem(
                value: option.key,
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage(option.assetPath),
                      size: 16.w,
                      color: darkBlue.withOpacity(0.7),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      option.label,
                      style: context.subStyle.copyWith(
                        color: darkBlue.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              if (value == null || value == 'none') {
                _iconKey = '';
                _typeLabel = '';
                return;
              }
              final picked = widget.typeOptions.firstWhere(
                (option) => option.key == value,
              );
              _iconKey = picked.key;
              _typeLabel = picked.label;
            });
          },
        ),
      ),
    );
  }
}
