import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/appearance/remind/data/models/remind_model.dart';

class AppStorage {
  //App Storage box
  static final box = GetStorage();

  static final write = WriteStorage(box);
  static final remove = RemoveStorage(box);

  //Get  Strorage
  static String get appToken => box.read(tokenKey) ?? "";
  static String get appLocale => box.read(localeKey) ?? "ru";
  static String get themeFont => box.read(themeFontKey) ?? poppins;
  static String get noteSound => box.read(noteSoundKey) ?? custom;
  static bool get noteStatus => box.read(noteStatusKey) ?? true;
  static Color get themeColor =>
      Color(int.parse((box.read(themeColorKey) ?? orange.value).toString()));
  static Color get themeSecondColor => Color(
    int.parse((box.read(themeSecondColorKey) ?? orangeAccent.value).toString()),
  );
  static List<RemindModel> get reminders {
    log(
      "GET REMINDERS ${((box.read(reminderKey) ?? []) as List).map((elm) => elm).toList()}",
    );

    return ((box.read(reminderKey) ?? []) as List)
        .map((elm) => RemindModel.fromJson(elm))
        .toList();
  }
}

//Write  Storage
class WriteStorage {
  final GetStorage box;
  WriteStorage(this.box);

  Future<void> token(String token) => box.write(tokenKey, token);
  Future<void> locale(String lang) => box.write(localeKey, lang);
  Future<void> themeColor(Color color) => box.write(themeColorKey, color.value);
  Future<void> themeSecondColor(Color color) =>
      box.write(themeSecondColorKey, color.value);
  Future<void> themeFont(String font) => box.write(themeFontKey, font);
  Future<void> noteSound(String sound) => box.write(noteSoundKey, sound);
  Future<void> noteStatus(bool status) => box.write(noteStatusKey, status);

  //save reminders
  Future<void> reminders(List<RemindModel> list) async {
    log("SAVE REMINDERS ${list.map((e) => e.toJson()).toList()}");
    await box.write(reminderKey, list.map((e) => e.toJson()).toList());
  }
}

//Edit  Storage
class RemoveStorage {
  final GetStorage box;
  RemoveStorage(this.box);

  Future<void> get erase async => await box.erase();
  Future<void> get token async => await box.remove(tokenKey);
  Future<void> get reminders async => await box.remove(reminderKey);
}

//keys of storage
const String tokenKey = 'app_token';
const String localeKey = 'app_locale';
const String themeColorKey = 'theme_color';
const String themeSecondColorKey = 'theme_second_color';
const String themeFontKey = 'theme_font';
const String noteSoundKey = 'note_sound';
const String noteStatusKey = 'note_status';
const String reminderKey = 'all_reminders';
