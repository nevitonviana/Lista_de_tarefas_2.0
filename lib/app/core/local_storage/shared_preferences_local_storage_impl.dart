import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

class SharedPreferencesLocalStorageImpl implements LocalStorage {
  Future<SharedPreferences> get _instance => SharedPreferences.getInstance();

  @override
  Future<void> clear() async {
    final sharedPreferences = await _instance;
    sharedPreferences.clear();
  }

  @override
  Future<bool> contains<V>(String key) async {
    final sharedPreferences = await _instance;
    return sharedPreferences.containsKey(key);
  }

  @override
  Future<V?> read<V>(String key) async {
    final sharedPreferences = await _instance;
    return sharedPreferences.get(key) as V?;
  }

  @override
  Future<void> remove(String key) async {
    final sharedPreferences = await _instance;
    sharedPreferences.remove(key);
  }

  @override
  Future<V?> write<V>(String key, V value) async {
    final sharedPreferences = await _instance;
    switch (V) {
      case const (String):
        sharedPreferences.setString(key, value as String);
        break;

      case const (int):
        sharedPreferences.setInt(key, value as int);
        break;

      case const (bool):
        sharedPreferences.setBool(key, value as bool);
        break;

      case const (double):
        sharedPreferences.setDouble(key, value as double);
        break;

      case const (List<String>):
        sharedPreferences.setStringList(key, value as List<String>);
        break;

      default:
        throw Exception('Type not supported');
    }
    return null;
  }
}
