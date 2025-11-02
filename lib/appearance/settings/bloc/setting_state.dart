part of 'setting_bloc.dart';

// @freezed
// class SettingState with _$SettingState {
//   const factory SettingState.initial() = _Initial;
// }

abstract class SettingState {
  ThemeMode mode;
  bool statusNote;
  SettingState({this.mode = ThemeMode.light, this.statusNote = true});
}

class SettingInitState extends SettingState {
  SettingInitState({super.mode, super.statusNote});
}
