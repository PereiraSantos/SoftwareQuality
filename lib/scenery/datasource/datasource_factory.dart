abstract class DatasourceFactory {
  Future<void> createTable();
  Future<List<Map<String, Object?>>> find();
  Future<void> insert(Map<String, Object?> values);
  Future<int>? getLastId();
}
