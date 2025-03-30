import 'package:shared_preferences/shared_preferences.dart';

const String homeSelectedTabIndex = 'homeSelectedTabIndex';

class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _preferences;

  // Private constructor
  StorageService._();

  static Future<StorageService> getInstance() async {
    if (_instance == null) {
      _instance = StorageService._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // Write methods
  Future<bool> setString(String key, String value) async {
    return await _preferences?.setString(key, value) ?? false;
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences?.setInt(key, value) ?? false;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences?.setBool(key, value) ?? false;
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences?.setDouble(key, value) ?? false;
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences?.setStringList(key, value) ?? false;
  }

  // Read methods
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

  // Delete methods
  Future<bool> remove(String key) async {
    return await _preferences?.remove(key) ?? false;
  }

  Future<bool> clear() async {
    return await _preferences?.clear() ?? false;
  }

  // Check if key exists
  bool containsKey(String key) {
    return _preferences?.containsKey(key) ?? false;
  }
}
