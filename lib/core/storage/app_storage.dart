import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/utils/theme/app_colors.dart';

class AppStorage {
  //App Storage box
  static var box = GetStorage();

  //Get  Strorage
  static String get appToken => box.read(tokenKey) ?? "";
  static String get appLocale => box.read(localeKey) ?? "ru";
  static Color get themeColor =>
      Color(int.parse((box.read(themeColorKey) ?? orange.value).toString()));
  static Color get themeSecondColor => Color(
    int.parse((box.read(themeSecondColorKey) ?? orangeAccent.value).toString()),
  );
  static String get themeFont => box.read(themeFontKey) ?? poppins;
  static String get noteSound => box.read(noteSoundKey) ?? custom;
  static bool get noteStatus => box.read(noteStatusKey) ?? true;

  //Write  Storage
  static Future<void> writeToken(String token) => box.write(tokenKey, token);
  static Future<void> writeLocale(String lang) => box.write(localeKey, lang);
  static Future<void> writeThemeColor(Color color) =>
      box.write(themeColorKey, color.value);
  static Future<void> writeThemeSecondColor(Color color) =>
      box.write(themeSecondColorKey, color.value);
  static Future<void> writeThemeFont(String font) =>
      box.write(themeFontKey, font);
  static Future<void> writeNoteSound(String sound) =>
      box.write(noteSoundKey, sound);
  static Future<void> writeNoteStatus(bool status) =>
      box.write(noteStatusKey, status);

  //Remove Storage
  static Future<void> get eraseStorage async => await box.erase();
  static Future<void> get removeToken async => await box.remove(tokenKey);
}

//keys of storage
const String tokenKey = 'app_token';
const String localeKey = 'app_locale';
const String themeColorKey = 'theme_color';
const String themeSecondColorKey = 'theme_second_color';
const String themeFontKey = 'theme_font';
const String noteSoundKey = 'note_sound';
const String noteStatusKey = 'note_status';
