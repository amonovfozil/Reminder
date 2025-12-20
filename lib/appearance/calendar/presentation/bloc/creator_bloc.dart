import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reminder/appearance/calendar/data/models/types/cyclic_remind.dart';
import '../../data/models/remind_model.dart';
import '../../data/models/types/weekly_remind.dart';
import '../../data/models/types/multiple_remind.dart';
import '../../data/models/types/interval_remind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'creator_event.dart';
part 'creator_state.dart';
part 'creator_bloc.freezed.dart';

class CreatorBloc extends Bloc<CreatorEvent, CreatorState> {
  CreatorBloc() : super(InitialCreatorState(remind: defaultModel)) {
    on<_Started>(_onStrated);
    on<_UpdateData>(_onUpdateData);
  }

  //Functions
  void _onStrated(_Started event, emit) {
    emit(InitialCreatorState(remind: defaultModel));
  }

  void _onUpdateData(_UpdateData event, emit) =>
      emit(InitialCreatorState(remind: event.data));
}

DateTime now = DateTime.now();
final intervalModel = IntervalRemindModel(
  id: UniqueKey().toString(),
  startDate: now.copyWith(hour: 6, minute: 0, second: 0, millisecond: 0),
  endDate: now.copyWith(hour: 22, minute: 0, second: 0, millisecond: 0),
  times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
);

final multipleRemindModel = MultipleRemindModel(
  id: UniqueKey().toString(),
  times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
);

final weeklyRemindModel = WeeklyRemindModel(
  id: UniqueKey().toString(),
  days: [0, 2, 4],
);

final cyclicRemindModel = CyclicRemindModel(
  id: UniqueKey().toString(),
  startDate: DateTime.now(),
);

final defaultModel = RemindModel(id: UniqueKey().toString());
