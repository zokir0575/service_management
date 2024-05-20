import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  static StorageRepository? _storageUtil;
  static SharedPreferences? _preferences;

  static Future<StorageRepository> getInstance() async {
    if (_storageUtil == null) {
      final secureStorage = StorageRepository._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil!;
  }

  StorageRepository._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool getBool(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences!.getBool(key) ?? defValue;
  }

  static Future<bool>? putBool({required String key, required bool value}) {
    if (_preferences == null) return null;
    return _preferences!.setBool(key, value);
  }

  static Future<bool>? deleteBool(String key) {
    if (_preferences == null) return null;
    return _preferences!.remove(key);
  }
}
