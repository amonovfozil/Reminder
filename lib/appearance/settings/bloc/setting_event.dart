part of 'setting_bloc.dart';

@freezed
abstract class SettingEvent with _$SettingEvent {
  const factory SettingEvent.init() = _Init;
  const factory SettingEvent.setColor({
    required BuildContext ctx,
    required Color color,
  }) = _SetColor;

  const factory SettingEvent.setFont({
    required BuildContext ctx,
    required String font,
  }) = _SetFont;

  const factory SettingEvent.changeLocale({
    required BuildContext ctx,
    required String code,
  }) = _ChangeLocale;
}
