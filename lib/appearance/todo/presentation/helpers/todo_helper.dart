import 'package:flutter/material.dart';
import 'package:reminder/appearance/todo/data/models/todo_day_model.dart';
import 'package:reminder/appearance/todo/data/models/todo_task_model.dart';

enum TodoStatus { doneOnTime, late, notDone, pending }

class TodoHelper {
  static DateTime onlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isToday(DateTime date) => isSameDate(date, DateTime.now());

  static bool isPast(DateTime date) =>
      onlyDate(date).isBefore(onlyDate(DateTime.now()));

  static TodoDayModel getDay(
    List<TodoDayModel> days,
    DateTime date, {
    bool createIfMissing = false,
  }) {
    final day = days.where((d) => isSameDate(d.date, date)).toList();
    if (day.isNotEmpty) return day.first;
    if (!createIfMissing) {
      return TodoDayModel(date: onlyDate(date), tasks: []);
    }
    final newDay = TodoDayModel(date: onlyDate(date), tasks: []);
    days.add(newDay);
    return newDay;
  }

  static TodoStatus statusForTask(TodoTaskModel task, DateTime day) {
    if (task.completedAt != null) {
      return task.completedAt!.isAfter(task.plannedAt)
          ? TodoStatus.late
          : TodoStatus.doneOnTime;
    }

    if (DateTime.now().isAfter(task.plannedAt)) {
      return TodoStatus.notDone;
    }

    return TodoStatus.pending;
  }

  static Color colorForStatus(
    TodoStatus status, {
    required Color doneColor,
    required Color lateColor,
    required Color notDoneColor,
    required Color pendingColor,
  }) {
    return switch (status) {
      TodoStatus.doneOnTime => doneColor,
      TodoStatus.late => lateColor,
      TodoStatus.notDone => notDoneColor,
      TodoStatus.pending => pendingColor,
    };
  }

  static Color? calendarStatusColor(
    List<TodoDayModel> days,
    DateTime day, {
    required Color doneColor,
    required Color lateColor,
    required Color notDoneColor,
    required Color pendingColor,
  }) {
    final tasks = getDay(days, day).tasks;
    if (tasks.isEmpty) return null;

    final completed = tasks.where((t) => t.completedAt != null).toList();
    final anyLate = tasks.any((t) => statusForTask(t, day) == TodoStatus.late);
    final anyOverdue = tasks.any(
      (t) => statusForTask(t, day) == TodoStatus.notDone,
    );

    if (completed.isEmpty && !anyOverdue) return pendingColor;
    if (completed.isEmpty) return notDoneColor;
    if (completed.length == tasks.length && !anyLate) return doneColor;
    if (!anyLate && !anyOverdue) return pendingColor;
    return lateColor;
  }

  static ({int doneOnTime, int late, int notDone, int pending}) statusCounts(
    List<TodoDayModel> days,
    DateTime day,
  ) {
    final tasks = getDay(days, day).tasks;
    int doneOnTime = 0;
    int late = 0;
    int notDone = 0;
    int pending = 0;

    for (final task in tasks) {
      switch (statusForTask(task, day)) {
        case TodoStatus.doneOnTime:
          doneOnTime++;
          break;
        case TodoStatus.late:
          late++;
          break;
        case TodoStatus.notDone:
          notDone++;
          break;
        case TodoStatus.pending:
          pending++;
          break;
      }
    }

    return (
      doneOnTime: doneOnTime,
      late: late,
      notDone: notDone,
      pending: pending,
    );
  }

  static String? assetByKey(String key) {
    return switch (key) {
      'meeting' => 'assets/images/home/users.png',
      'call' => 'assets/images/home/emails.png',
      'health' => 'assets/images/home/docUser.png',
      'shopping' => 'assets/images/home/bag.png',
      'work' => 'assets/images/home/remind.png',
      'study' => 'assets/images/home/calendar_edit.png',
      _ => null,
    };
  }
}
