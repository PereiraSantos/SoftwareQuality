abstract class DatasourceFactory {
  Future<List<Map<String, Object?>>> find();
  Future<void> insert(Map<String, Object?> values);
  Future<void> update(Map<String, Object?> values);
  Future<int>? getLastId();
  Future<void> delete(int id);
}
