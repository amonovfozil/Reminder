part of 'setting_bloc.dart';

@freezed
abstract class SettingEvent with _$SettingEvent {
  const factory SettingEvent.init() = _Init;
  const factory SettingEvent.togglestatus({required bool status}) =
      _ToggleStatus;

  const factory SettingEvent.setColor({
    required Color color,
    required Color secondary,
  }) = _SetColor;
  const factory SettingEvent.setFont({
    required BuildContext ctx,
    required String font,
  }) = _SetFont;

  const factory SettingEvent.setSound({
    required BuildContext ctx,
    required String sound,
  }) = _SetSound;

  const factory SettingEvent.changeLocale({
    required BuildContext ctx,
    required String code,
  }) = _ChangeLocale;
}
