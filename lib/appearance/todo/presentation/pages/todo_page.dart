import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/core/helpers/formatter.dart';
import 'package:reminder/core/UI/screens/custom_backgraund_style.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import 'package:reminder/appearance/todo/data/models/todo_task_model.dart';
import 'package:reminder/appearance/todo/presentation/bloc/todo_bloc.dart';
import 'package:reminder/appearance/todo/presentation/helpers/todo_helper.dart';
import 'package:reminder/appearance/todo/presentation/widgets/cutom_calendar.dart';
import 'package:reminder/appearance/todo/presentation/widgets/todo_task_card.dart';
import 'package:reminder/appearance/todo/presentation/widgets/todo_task_editor_sheet.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  static const List<TodoTypeOption> typeOptions = [
    TodoTypeOption(
      key: 'work',
      label: 'Work',
      assetPath: 'assets/images/home/remind.png',
    ),
    TodoTypeOption(
      key: 'meeting',
      label: 'Meeting',
      assetPath: 'assets/images/home/users.png',
    ),
    TodoTypeOption(
      key: 'call',
      label: 'Call',
      assetPath: 'assets/images/home/emails.png',
    ),
    TodoTypeOption(
      key: 'health',
      label: 'Health',
      assetPath: 'assets/images/home/docUser.png',
    ),
    TodoTypeOption(
      key: 'shopping',
      label: 'Shopping',
      assetPath: 'assets/images/home/bag.png',
    ),

    TodoTypeOption(
      key: 'study',
      label: 'Study',
      assetPath: 'assets/images/home/calendar_edit.png',
    ),
  ];

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final Color _doneColor = green;
  final Color _lateColor = Colors.amber;
  final Color _notDoneColor = Colors.redAccent;

  void _shiftSelectedDate(int days) {
    final current = context.read<TodoBloc>().state.selectedDate;
    context.read<TodoBloc>().add(
      TodoSelectDate(current.add(Duration(days: days))),
    );
  }

  Future<void> _openTaskEditor({
    required DateTime selectedDate,
    TodoTaskModel? task,
  }) async {
    if (TodoHelper.isPast(selectedDate)) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: TodoTaskEditorSheet(
            task: task,
            selectedDate: selectedDate,
            typeOptions: TodoPage.typeOptions,
            onSave: (title, note, plannedAt, iconKey, typeLabel) {
              context.read<TodoBloc>().add(
                TodoAddOrUpdateTask(
                  title: title,
                  note: note,
                  plannedAt: plannedAt,
                  iconKey: iconKey,
                  typeLabel: typeLabel,
                  task: task,
                ),
              );
              Navigator.of(ctx).pop();
            },
            onDelete: task == null
                ? null
                : () {
                    context.read<TodoBloc>().add(TodoDeleteTask(task));
                    Navigator.of(ctx).pop();
                  },
          ),
        );
      },
    );
  }

  void _toggleDone(TodoTaskModel task) {
    context.read<TodoBloc>().add(TodoToggleTask(task));
  }

  Future<void> _openCalendarSheet(DateTime selectedDate) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: context.borderColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 12.h),
              CustomCalendar(
                primaryColor: context.primaryColor,
                todayColor: context.secondaryColor,
                initialDate: selectedDate,
                minDate: DateTime.now().subtract(const Duration(days: 360)),
                maxDate: DateTime.now().add(const Duration(days: 360)),
                dayBackgroundColorBuilder: (day) =>
                    TodoHelper.calendarStatusColor(
                      context.read<TodoBloc>().state.days,
                      day,
                      doneColor: _doneColor,
                      lateColor: _lateColor,
                      notDoneColor: _notDoneColor,
                      pendingColor: context.borderColor,
                    ),
                dayMarkerColorBuilder: (day) => TodoHelper.calendarStatusColor(
                  context.read<TodoBloc>().state.days,
                  day,
                  doneColor: _doneColor,
                  lateColor: _lateColor,
                  notDoneColor: _notDoneColor,
                  pendingColor: context.borderColor,
                ),
                onDateSelected: (date) {
                  context.read<TodoBloc>().add(TodoSelectDate(date));
                  Navigator.of(ctx).pop();
                },
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        final tasks = List<TodoTaskModel>.from(
          TodoHelper.getDay(state.days, state.selectedDate).tasks,
        )..sort((a, b) => a.plannedAt.compareTo(b.plannedAt));
        final canEdit = !TodoHelper.isPast(state.selectedDate);

        return CustomScaffold(
          withBackGround: false,
          backgroundColor: Colors.transparent,
          title: 'TODO',

          body: Padding(
            padding: EdgeInsets.only(
              left: marginVal.w,
              right: marginVal.w,
              bottom: 24.h,
              top: spacingVal.h,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _DateNavSquareButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: () => _shiftSelectedDate(-1),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: InkWell(
                        onTap: () => _openCalendarSheet(state.selectedDate),
                        borderRadius: BorderRadius.circular(18.r),
                        child: Container(
                          // height: 45.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: TodoHelper.isToday(state.selectedDate)
                                ? 8.h
                                : 14.h,
                          ).scaled,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(
                              color: context.borderColor.withOpacity(0.08),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    Formatter.dayMonthBy(
                                      state.selectedDate,
                                      atribut: ' ',
                                    ),
                                    style: context.titleTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 4.h),
                                  if (TodoHelper.isToday(state.selectedDate))
                                    Text(
                                      'Bugungi reja',
                                      style: context.subStyle.copyWith(
                                        color: darkBlue.withOpacity(0.75),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    _DateNavSquareButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: () => _shiftSelectedDate(1),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: tasks.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 40.h),
                            child: Column(
                              spacing: 10,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.hourglass_empty_rounded,
                                  color: white,
                                  size: 40.w,
                                ),
                                Text(
                                  'Rejalar yo\'q',
                                  style: context.titleTextStyle.copyWith(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.separated(
                                padding: EdgeInsets.only(bottom: 24.h),
                                itemCount: tasks.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 10.h),
                                itemBuilder: (ctx, index) {
                                  final task = tasks[index];
                                  final status = TodoHelper.statusForTask(
                                    task,
                                    state.selectedDate,
                                  );
                                  final color = TodoHelper.colorForStatus(
                                    status,
                                    doneColor: _doneColor,
                                    lateColor: _lateColor,
                                    notDoneColor: _notDoneColor,
                                    pendingColor: context.borderColor,
                                  );

                                  return TodoTaskCard(
                                    title: task.title,
                                    timeLabel: Formatter.timeFormat(
                                      task.plannedAt,
                                    ),
                                    note: task.note,
                                    statusColor: color,
                                    isDone: task.isDone,
                                    isEditable: canEdit,
                                    iconPath: TodoHelper.assetByKey(
                                      task.iconKey,
                                    ),
                                    typeLabel: task.typeLabel,
                                    onToggle: () => _toggleDone(task),
                                    onEdit: () => _openTaskEditor(
                                      selectedDate: state.selectedDate,
                                      task: task,
                                    ),
                                    onDelete: () => context
                                        .read<TodoBloc>()
                                        .add(TodoDeleteTask(task)),
                                  );
                                },
                              ),
                              SizedBox(height: 80.h),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DateNavSquareButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _DateNavSquareButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        overlayColor: WidgetStatePropertyAll(
          context.secondaryColor.withOpacity(0.06),
        ),
        child: Container(
          width: 45.w,
          height: 45.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.borderColor.withOpacity(0.08)),
          ),
          child: Icon(icon, color: context.primaryColor, size: 28.w),
        ),
      ),
    );
  }
}
