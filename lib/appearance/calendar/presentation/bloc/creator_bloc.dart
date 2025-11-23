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

IntervalRemindModel intervalModel = IntervalRemindModel(
  id: UniqueKey().toString(),
  times: [],
);

MultipleRemindModel multipleRemindModel = MultipleRemindModel(
  id: UniqueKey().toString(),
  times: [],
);

WeeklyRemindModel weeklyRemindModel = WeeklyRemindModel(
  id: UniqueKey().toString(),
  days: [0, 2, 4],
);

CyclicRemindModel cyclicRemindModel = CyclicRemindModel(
  id: UniqueKey().toString(),
  startDate: DateTime.now(),
);

RemindModel defaultModel = RemindModel(id: UniqueKey().toString());
