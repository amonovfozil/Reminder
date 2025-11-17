part of 'alarm_bloc.dart';

@freezed
class AlarmEvent with _$AlarmEvent {
  const factory AlarmEvent.started() = _Started;
}