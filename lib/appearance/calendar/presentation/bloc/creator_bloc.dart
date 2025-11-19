import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reminder/appearance/calendar/data/models/types/multiple_remind.dart';
import '../../data/models/remind_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/types/interval_remind.dart';

part 'creator_event.dart';
part 'creator_state.dart';
part 'creator_bloc.freezed.dart';

class CreatorBloc extends Bloc<CreatorEvent, CreatorState> {
  CreatorBloc() : super(InitialCreatorState(remind: defaultModel)) {
    on<_Started>(_onStrated);
    on<_UpdateData>(_onUpdateData);
  }

  //Functions
  void _onStrated(_Started event, emit) {}
  void _onUpdateData(_UpdateData event, emit) =>
      emit(InitialCreatorState(remind: event.data));
}

RemindModel defaultModel = RemindModel(id: UniqueKey().toString());

IntervalRemindModel intervalModel = IntervalRemindModel(
  id: UniqueKey().toString(),
  times: [],
);
MultipleRemindModel multipleRemindModel = MultipleRemindModel(
  id: UniqueKey().toString(),
  times: [],
);
