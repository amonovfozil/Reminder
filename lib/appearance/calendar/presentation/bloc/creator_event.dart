part of 'creator_bloc.dart';

@freezed
class CreatorEvent with _$CreatorEvent {
  const factory CreatorEvent.started() = _Started;
  const factory CreatorEvent.updateData({required RemindModel data}) =
      _UpdateData;
}
