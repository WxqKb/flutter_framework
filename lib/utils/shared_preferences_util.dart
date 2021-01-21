import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static SpUtil _spUtil;
  static SharedPreferences _preferences;

  /// 获取shared preferences实例
  static Future<SpUtil> getInstance() async{
    if (_spUtil == null) {
      _spUtil = SpUtil.internal();
      if (_preferences == null) {
        _preferences = await SharedPreferences.getInstance();
      }
    }
    return _spUtil;
  }

  SpUtil.internal();

  /// 保存字符串
  static Future<bool> setString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value);
  }

  /// 获取字符串
  static String getString(String key, {String defValue = ""}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }

  /// 保存布尔值
  static Future<bool> setBool(String key, bool value) {
    if (_preferences == null) return null;
    return _preferences.setBool(key, value);
  }

  /// 获取布尔值
  static bool getBool(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences.getBool(key);
  }

  /// 保存整形值
  static Future<bool> setInt(String key, int value) {
    if (_preferences == null) return null;
    return _preferences.setInt(key, value);
  }

  /// 获取整形值
  static int getInt(String key, {int defValue = 0}) {
    if (_preferences == null) return defValue;
    return _preferences.getInt(key) ?? defValue;
  }

  /// 设置浮点值
  static Future<bool> setDouble(String key, double value) {
    if (_preferences == null) return null;
    return _preferences.setDouble(key, value);
  }

  /// 获取浮点值
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_preferences == null) return defValue;
    return _preferences.getDouble(key) ?? defValue;
  }

  /// 判断shared preferences是否包含某个键
  static bool contains(String key) {
    if (_preferences == null) return null;
    return _preferences.getKeys().contains(key);
  }

  /// 获取shared preferences所有键
  static Set<String> getKeys() {
    if (_preferences == null) return null;
    return _preferences.getKeys();
  }

  /// 删除某个值
  static Future<bool> remove(String key) {
    if (_preferences == null) return null;
    return _preferences.remove(key);
  }

  /// 清空shared preferences
  static Future<bool> clear() {
    if (_preferences == null) return null;
    return _preferences.clear();
  }
}
