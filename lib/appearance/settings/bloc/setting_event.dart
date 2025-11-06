part of 'setting_bloc.dart';

@freezed
abstract class SettingEvent with _$SettingEvent {
  const factory SettingEvent.init() = _Init;
  const factory SettingEvent.setColor({
    required Color color,
    required Color secondary,
  }) = _SetColor;
  const factory SettingEvent.setFont({required String font}) = _SetFont;

  const factory SettingEvent.changeLocale({
    required BuildContext ctx,
    required String code,
  }) = _ChangeLocale;
}
