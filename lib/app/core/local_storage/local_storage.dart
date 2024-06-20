abstract class LocalStorage {
  Future<V?> read<V>(String key);

  Future<V?> write<V>(String key, V value);

  Future<bool> contains<V>(String key);

  Future<void> clear();

  Future<void> remove(String key);
}
