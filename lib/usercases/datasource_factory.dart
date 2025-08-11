abstract class DatasourceFactory {
  Future<List<Map<String, Object?>>> find();
  Future<void> insert(Map<String, Object?> values);
  Future<int>? getLastId();
}
