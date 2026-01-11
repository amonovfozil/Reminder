part of 'todo_bloc.dart';

abstract class TodoEvent {
  const TodoEvent();
}

class TodoInit extends TodoEvent {
  const TodoInit();
}

class TodoSelectDate extends TodoEvent {
  final DateTime date;
  const TodoSelectDate(this.date);
}

class TodoAddOrUpdateTask extends TodoEvent {
  final TodoTaskModel? task;
  final String title;
  final String note;
  final DateTime plannedAt;
  final String iconKey;
  final String typeLabel;

  const TodoAddOrUpdateTask({
    required this.title,
    required this.note,
    required this.plannedAt,
    required this.iconKey,
    required this.typeLabel,
    this.task,
  });
}

class TodoToggleTask extends TodoEvent {
  final TodoTaskModel task;
  const TodoToggleTask(this.task);
}

class TodoDeleteTask extends TodoEvent {
  final TodoTaskModel task;
  const TodoDeleteTask(this.task);
}
