part of 'setting_bloc.dart';

@freezed
abstract class SettingEvent with _$SettingEvent {
  const factory SettingEvent.init() = _Init;
  const factory SettingEvent.changeMode({
    required BuildContext ctx,
    required ThemeMode mode,
  }) = _ChangeMode;

  const factory SettingEvent.changeLocale({
    required BuildContext ctx,
    required String code,
  }) = _ChangeLocale;
}
