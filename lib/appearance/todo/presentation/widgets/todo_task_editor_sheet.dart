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
  late final List<IconPickerItem> _iconItems;

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
    _iconItems = [
      ...widget.typeOptions.map(
        (option) => IconPickerItem(
          key: option.key,
          label: option.label,
          assetPath: option.assetPath,
        ),
      ),
    ];
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
          Row(
            spacing: 10,
            children: [
              CustomScrollDown(
                items: _iconItems,
                selectedKey: _iconKey,
                onSelected: (picked) {
                  setState(() {
                    _iconKey = picked.key;
                    _typeLabel = picked.key.isEmpty ? '' : picked.label;
                  });
                },
              ),
              Expanded(
                child: CustomTextField(
                  controller: _titleCtrl,
                  validator: (val) => (val == null || val.trim().isEmpty)
                      ? 'Sarlavha kiriting'
                      : null,
                  labelText: 'Nomi',
                  hintText: 'Bugungi ish',
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: _noteCtrl,
            validator: (_) => null,
            labelText: 'Izoh',
            hintText: 'Ixtiyoriy izoh',
            maxLines: 2,
          ),

          // SizedBox(height: 12.h),
          // Text('Icon/Type (ixtiyoriy)', style: context.subStyle),
          // SizedBox(height: 8.h),
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
}

class IconPickerItem {
  final String key;
  final String label;
  final String? assetPath;

  const IconPickerItem({
    required this.key,
    required this.label,
    required this.assetPath,
  });
}

class CustomScrollDown extends StatefulWidget {
  final List<IconPickerItem> items;
  final String selectedKey;
  final ValueChanged<IconPickerItem> onSelected;

  const CustomScrollDown({
    super.key,
    required this.items,
    required this.selectedKey,
    required this.onSelected,
  });

  @override
  State<CustomScrollDown> createState() => _CustomScrollDownState();
}

class _CustomScrollDownState extends State<CustomScrollDown> {
  final LayerLink _iconPickerLink = LayerLink();
  OverlayEntry? _iconPickerEntry;

  @override
  void dispose() {
    _removeIconPicker();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = widget.items.firstWhere(
      (item) => item.key == widget.selectedKey,
      orElse: () => widget.items.first,
    );

    return CompositedTransformTarget(
      link: _iconPickerLink,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: _toggleIconPicker,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: context.secondaryColor.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: context.borderColor),
              ),
              child: selectedItem.assetPath == null
                  ? Icon(
                      Icons.remove_circle_outline,
                      size: 20.w,
                      color: darkBlue.withOpacity(0.7),
                    )
                  : ImageIcon(
                      AssetImage(selectedItem.assetPath!),
                      size: 20.w,
                      color: context.primaryColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleIconPicker() {
    if (_iconPickerEntry != null) {
      _removeIconPicker();
      return;
    }

    final initialIndex = widget.items.indexWhere(
      (item) => item.key == widget.selectedKey,
    );
    final controller = FixedExtentScrollController(
      initialItem: initialIndex < 0 ? 0 : initialIndex,
    );

    _iconPickerEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeIconPicker,
                behavior: HitTestBehavior.translucent,
              ),
            ),
            CompositedTransformFollower(
              link: _iconPickerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.center,
              followerAnchor: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 50.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: context.secondaryColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      NotificationListener<ScrollEndNotification>(
                        onNotification: (_) {
                          final index = controller.selectedItem;
                          final picked = widget.items[index];
                          widget.onSelected(picked);
                          _removeIconPicker();
                          return false;
                        },
                        child: ListWheelScrollView.useDelegate(
                          controller: controller,
                          physics: const FixedExtentScrollPhysics(),
                          itemExtent: 50.h,
                          perspective: 0.002,
                          squeeze: 1,
                          diameterRatio: 1.6,
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: widget.items.length,
                            builder: (context, index) {
                              final item = widget.items[index];
                              return Center(
                                child: item.assetPath == null
                                    ? Icon(
                                        Icons.remove_circle_outline,
                                        size: 20.w,
                                        color: darkBlue.withOpacity(0.7),
                                      )
                                    : ImageIcon(
                                        AssetImage(item.assetPath!),
                                        size: 20.w,
                                        color: white,
                                        // color: context.primaryColor,
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      IgnorePointer(
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context, rootOverlay: true).insert(_iconPickerEntry!);
  }

  void _removeIconPicker() {
    _iconPickerEntry?.remove();
    _iconPickerEntry = null;
  }
}
