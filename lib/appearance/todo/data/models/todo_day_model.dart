import 'todo_task_model.dart';

class TodoDayModel {
  DateTime date;
  List<TodoTaskModel> tasks;

  TodoDayModel({required this.date, required this.tasks});

  TodoDayModel copyWith({DateTime? date, List<TodoTaskModel>? tasks}) {
    return TodoDayModel(date: date ?? this.date, tasks: tasks ?? this.tasks);
  }

  factory TodoDayModel.fromJson(Map<String, dynamic> json) => TodoDayModel(
    date: _parseDate(json['date']) ?? DateTime.now(),
    tasks: (json['tasks'] as List? ?? [])
        .map((e) => TodoTaskModel.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'tasks': tasks.map((e) => e.toJson()).toList(),
  };
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}
