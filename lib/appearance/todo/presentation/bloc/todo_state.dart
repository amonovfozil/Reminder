part of 'todo_bloc.dart';

class TodoState {
  final DateTime selectedDate;
  final List<TodoDayModel> days;

  const TodoState({
    required this.selectedDate,
    required this.days,
  });

  factory TodoState.initial() => TodoState(
        selectedDate: DateTime.now(),
        days: const [],
      );

  TodoState copyWith({
    DateTime? selectedDate,
    List<TodoDayModel>? days,
  }) {
    return TodoState(
      selectedDate: selectedDate ?? this.selectedDate,
      days: days ?? this.days,
    );
  }
}
