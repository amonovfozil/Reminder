import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reminder/core/storage/app_storage.dart';
import 'package:reminder/appearance/todo/data/models/todo_day_model.dart';
import 'package:reminder/appearance/todo/data/models/todo_task_model.dart';
import 'package:reminder/appearance/todo/presentation/helpers/todo_helper.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState.initial()) {
    on<TodoInit>(_onInit);
    on<TodoSelectDate>(_onSelectDate);
    on<TodoAddOrUpdateTask>(_onAddOrUpdate);
    on<TodoToggleTask>(_onToggleTask);
    on<TodoDeleteTask>(_onDeleteTask);
  }

  Future<void> _onInit(TodoInit event, Emitter<TodoState> emit) async {
    var days = AppStorage.todoDays;
    if (days.isEmpty) {
      days = _seedSampleDays();
      await AppStorage.write.todoDays(days);
    }
    emit(state.copyWith(days: days, selectedDate: DateTime.now()));
  }

  void _onSelectDate(TodoSelectDate event, Emitter<TodoState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  Future<void> _onAddOrUpdate(
    TodoAddOrUpdateTask event,
    Emitter<TodoState> emit,
  ) async {
    if (TodoHelper.isPast(state.selectedDate)) return;

    final days = _copyDays(state.days);
    final day = TodoHelper.getDay(
      days,
      state.selectedDate,
      createIfMissing: true,
    );

    if (event.task == null) {
      day.tasks.add(
        TodoTaskModel(
          id: UniqueKey().toString(),
          title: event.title,
          note: event.note,
          plannedAt: event.plannedAt,
          iconKey: event.iconKey,
          typeLabel: event.typeLabel,
        ),
      );
    } else {
      final index = day.tasks.indexWhere((t) => t.id == event.task!.id);
      if (index != -1) {
        day.tasks[index] = event.task!.copyWith(
          title: event.title,
          note: event.note,
          plannedAt: event.plannedAt,
          iconKey: event.iconKey,
          typeLabel: event.typeLabel,
        );
      }
    }

    await AppStorage.write.todoDays(days);
    emit(state.copyWith(days: days));
  }

  Future<void> _onToggleTask(
    TodoToggleTask event,
    Emitter<TodoState> emit,
  ) async {
    if (TodoHelper.isPast(state.selectedDate)) return;

    final days = _copyDays(state.days);
    final day = TodoHelper.getDay(
      days,
      state.selectedDate,
      createIfMissing: true,
    );
    final index = day.tasks.indexWhere((t) => t.id == event.task.id);
    if (index == -1) return;

    final current = day.tasks[index];
    day.tasks[index] = current.copyWith(
      completedAt: current.isDone ? null : DateTime.now(),
    );

    await AppStorage.write.todoDays(days);
    emit(state.copyWith(days: days));
  }

  Future<void> _onDeleteTask(
    TodoDeleteTask event,
    Emitter<TodoState> emit,
  ) async {
    if (TodoHelper.isPast(state.selectedDate)) return;

    final days = _copyDays(state.days);
    final day = TodoHelper.getDay(
      days,
      state.selectedDate,
      createIfMissing: false,
    );
    day.tasks.removeWhere((t) => t.id == event.task.id);
    days.removeWhere((d) => d.tasks.isEmpty);

    await AppStorage.write.todoDays(days);
    emit(state.copyWith(days: days));
  }

  List<TodoDayModel> _copyDays(List<TodoDayModel> days) {
    return days
        .map(
          (day) => TodoDayModel(
            date: day.date,
            tasks: List<TodoTaskModel>.from(day.tasks),
          ),
        )
        .toList();
  }

  List<TodoDayModel> _seedSampleDays() {
    final year = DateTime.now().year;
    final jan7 = DateTime(year, 1, 7);
    final jan9 = DateTime(year, 1, 9);

    return [
      TodoDayModel(
        date: TodoHelper.onlyDate(jan7),
        tasks: [
          TodoTaskModel(
            id: 'sample-7-1',
            title: 'Hisobot topshirish',
            note: 'Namuna data',
            plannedAt: DateTime(year, 1, 7, 9, 0),
            completedAt: DateTime(year, 1, 7, 8, 50),
            iconKey: 'work',
            typeLabel: 'Work',
          ),
          TodoTaskModel(
            id: 'sample-7-2',
            title: 'Jamoa yig\'ilishi',
            note: 'Namuna data',
            plannedAt: DateTime(year, 1, 7, 11, 0),
            completedAt: DateTime(year, 1, 7, 10, 55),
            iconKey: 'meeting',
            typeLabel: 'Meeting',
          ),
          TodoTaskModel(
            id: 'sample-7-3',
            title: 'Telefon qo\'ng\'iroqlari',
            note: 'Namuna data',
            plannedAt: DateTime(year, 1, 7, 15, 0),
            completedAt: DateTime(year, 1, 7, 14, 45),
            iconKey: 'call',
            typeLabel: 'Call',
          ),
        ],
      ),
      TodoDayModel(
        date: TodoHelper.onlyDate(jan9),
        tasks: [
          TodoTaskModel(
            id: 'sample-9-1',
            title: 'Kunlik reja',
            note: 'Namuna data',
            plannedAt: DateTime(year, 1, 9, 10, 0),
            completedAt: DateTime(year, 1, 9, 10, 5),
            iconKey: 'study',
            typeLabel: 'Study',
          ),
          TodoTaskModel(
            id: 'sample-9-2',
            title: 'Dokumentlarni tekshirish',
            note: 'Namuna data',
            plannedAt: DateTime(year, 1, 9, 16, 0),
            iconKey: 'work',
            typeLabel: 'Work',
          ),
        ],
      ),
    ];
  }
}
