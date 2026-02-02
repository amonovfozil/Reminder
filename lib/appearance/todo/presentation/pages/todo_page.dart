import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/core/helpers/formatter.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import 'package:reminder/appearance/todo/data/models/todo_task_model.dart';
import 'package:reminder/appearance/todo/presentation/bloc/todo_bloc.dart';
import 'package:reminder/appearance/todo/presentation/helpers/todo_helper.dart';
import 'package:reminder/appearance/todo/presentation/widgets/cutom_calendar.dart';
import 'package:reminder/appearance/todo/presentation/widgets/todo_status_row.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoBloc>().add(const TodoInit());
    });
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
        final tasks = TodoHelper.getDay(state.days, state.selectedDate).tasks;
        final counts = TodoHelper.statusCounts(state.days, state.selectedDate);
        final canEdit = !TodoHelper.isPast(state.selectedDate);

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('TODO', style: context.headerTextStyle),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: tasks.isNotEmpty
                      ? (canEdit
                            ? () => _openTaskEditor(
                                selectedDate: state.selectedDate,
                              )
                            : null)
                      : () => _openCalendarSheet(state.selectedDate),
                  icon: tasks.isNotEmpty
                      ? Icon(Icons.add, color: white, size: 30.w)
                      : ImageIcon(
                          AssetImage('assets/images/home/calendar.png'),
                          color: white,
                          size: 25.w,
                        ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: marginVal.w,
                right: marginVal.w,
                bottom: 24.h,
                top: spacingVal.h,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => _openCalendarSheet(state.selectedDate),
                    borderRadius: BorderRadius.circular(18.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                          color: context.borderColor.withOpacity(0.08),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Formatter.dayMonthBy(
                                  state.selectedDate,
                                  atribut: ' ',
                                ),
                                style: context.subTitleTextStyle,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                TodoHelper.isToday(state.selectedDate)
                                    ? 'Bugungi reja'
                                    : 'Tanlangan kun',
                                style: context.subStyle.copyWith(
                                  color: darkBlue.withOpacity(0.75),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.expand_more, color: lightGrey),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TodoStatusRow(
                    total: tasks.length,
                    doneOnTime: counts.doneOnTime,
                    late: counts.late,
                    notDone: counts.notDone,
                    pending: counts.pending,
                    doneColor: _doneColor,
                    lateColor: _lateColor,
                    notDoneColor: _notDoneColor,
                    pendingColor: context.borderColor,
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: tasks.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 40.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Text(
                                      'Rejalar yo\'q',
                                      style: context.subStyle.copyWith(
                                        color: darkBlue.withOpacity(0.75),
                                        fontWeight: FontWeight.w600,
                                      ),
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
          ),
        );
      },
    );
  }
}
