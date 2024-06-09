import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  static const currentLocaleKey = 'currentLocale';
  static const apiTokenKey = 'apiToken';
  static const userInfoKey = 'currentUserInfo';

  static Future<bool> setLocale(Locale locale) =>
      saveString(currentLocaleKey, locale.languageCode);

  static Future<Locale?> loadCurrentLocale() async {
    final languageCode = await loadString(currentLocaleKey);
    return languageCode != null ? Locale(languageCode) : null;
  }

  static Future<bool> saveString(String key, String? value) async {
    if (value == null) return false;

    final sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(key, value);
  }

  static Future<bool> deleteLoggedUserInfo() => deleteKey(userInfoKey);

  static Future<String?> loadApiToken() => loadString(apiTokenKey);

  static Future<String?> loadString(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  static Future<bool> deleteKey(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(key);
  }
}
