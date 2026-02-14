import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/core/notifications/local_notifications_service.dart';
import 'package:reminder/core/storage/app_storage.dart';
import '../../../../core/constants/enums/remind_type.dart';
import '../../data/models/remind_model.dart';
import '../../data/models/types/cyclic_remind.dart';
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
    on<_Creat>(_onCreat);
  }

  //Functions
  void _onStrated(_Started event, emit) {
    emit(InitialCreatorState(remind: defaultModel));
  }

  void _onUpdateData(_UpdateData event, emit) =>
      emit(InitialCreatorState(remind: event.data));

  void _onCreat(_Creat event, emit) async {
    List<RemindModel> reminders = AppStorage.reminders;
    final existingIndex = reminders.indexWhere(
      (elm) => elm.id == state.remind.id,
    );
    final previous = existingIndex == -1 ? null : reminders[existingIndex];

    final updated = state.remind;
    updated.notificationIds = await LocalNotificationsService.instance
        .rescheduleReminder(updated, previous: previous);

    if (existingIndex == -1) {
      reminders.add(updated);
    } else {
      reminders[existingIndex] = updated;
    }
    await AppStorage.write.reminders(reminders);
    // await AppStorage.remove.reminders;
    await navigatorKey.currentState?.maybePop();
    add(CreatorEvent.updateData(data: defaultModel));
  }
}

RemindModel getModel(RemindType? type) {
  DateTime now = DateTime.now();

  return switch (type) {
    RemindType.interval => IntervalRemindModel(
      id: UniqueKey().toString(),
      startDate: now.copyWith(hour: 6, minute: 0, second: 0, millisecond: 0),
      endDate: now.copyWith(hour: 22, minute: 0, second: 0, millisecond: 0),
      times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
    ),
    RemindType.multiple => MultipleRemindModel(
      id: UniqueKey().toString(),
      times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
    ),
    RemindType.weekly => WeeklyRemindModel(
      id: UniqueKey().toString(),
      days: [0, 2, 4],
      times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
    ),
    RemindType.cyclic => CyclicRemindModel(
      id: UniqueKey().toString(),
      startDate: now,
      times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
    ),
    null => defaultModel,
  };
}
// final intervalModel = IntervalRemindModel(
//   id: UniqueKey().toString(),
//   startDate: now.copyWith(hour: 6, minute: 0, second: 0, millisecond: 0),
//   endDate: now.copyWith(hour: 22, minute: 0, second: 0, millisecond: 0),
//   times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
// );

// final multipleRemindModel = MultipleRemindModel(
//   id: UniqueKey().toString(),
//   times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
// );

// final weeklyRemindModel = WeeklyRemindModel(
//   id: UniqueKey().toString(),
//   days: [0, 2, 4],
//   times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
// );

// final cyclicRemindModel = CyclicRemindModel(
//   id: UniqueKey().toString(),
//   startDate: now,
//   times: [now.copyWith(hour: 8, minute: 0, second: 0, millisecond: 0)],
// );

final defaultModel = RemindModel(id: UniqueKey().toString());
