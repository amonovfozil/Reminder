part of 'setting_bloc.dart';

// @freezed
// class SettingState with _$SettingState {
//   const factory SettingState.initial() = _Initial;
// }

abstract class SettingState {
  ThemeData theme;
  bool noteStatus;
  String noteSound;
  SettingState({
    required this.theme,
    this.noteSound = custom,
    this.noteStatus = true,
  });
}

class SettingInitState extends SettingState {
  SettingInitState({required super.theme, super.noteSound, super.noteStatus});
}
