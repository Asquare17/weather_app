import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static final SharedPrefServices _instance = SharedPrefServices._ctor();

  factory SharedPrefServices() {
    return _instance;
  }

  SharedPrefServices._ctor();

  static late SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setString(String key, String value) {
    _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static setBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  static setDouble(String key, double value) {
    _prefs.setDouble(key, value);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  static setListValue(String key, List<String> list) {
    _prefs.setStringList(key, list);
  }

  static List<String> getListValue(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  static Map<String, dynamic> getAllPrefs() {
    final keys = _prefs.getKeys();
    final Map<String, dynamic> prefsMap = {};
    for (String key in keys) {
      prefsMap[key] = _prefs.get(key);
    }
    return prefsMap;
  }

  static remove(String key) {
    return _prefs.remove(key);
  }

  static clear() {
    return _prefs.clear();
  }
}
