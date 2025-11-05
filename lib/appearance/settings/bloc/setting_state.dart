part of 'setting_bloc.dart';

// @freezed
// class SettingState with _$SettingState {
//   const factory SettingState.initial() = _Initial;
// }

abstract class SettingState {
  ThemeData theme;
  bool statusNote;
  SettingState({
   required this.theme ,
    this.statusNote = true,
  });
}

class SettingInitState extends SettingState {
  SettingInitState({required super.theme, super.statusNote});
}
