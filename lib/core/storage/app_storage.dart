import 'package:get_storage/get_storage.dart';

class AppStorage {
  //App Storage box
  static var box = GetStorage();

  //Get  Strorage
  static String get appToken => box.read(tokenKey) ?? "";
  static String get appThemeMode => box.read(modeKey) ?? "light";
  static String get appLocale => box.read(localeKey) ?? "ru";

  //Write  Storage
  static Future<void> writeToken(String token) => box.write(tokenKey, token);
  static Future<void> writeLocale(String lang) => box.write(localeKey, lang);
  static Future<void> writeThemeMode(String mode) => box.write(modeKey, mode);

  //Remove Storage
  static Future<void> get eraseStorage async => await box.erase();
  static Future<void> get removeToken async => await box.remove(tokenKey);
  static Future<void> get removeThemeMode async => await box.remove(modeKey);
  static Future<void> get removeAppLocale async => await box.remove(localeKey);
}

//keys of storage
const String tokenKey = 'app_token';
const String localeKey = 'app_locale';
const String modeKey = 'app_theme_mode';
