import 'package:software_quality/scenery/datasource/datasource_factory.dart';
import 'package:software_quality/usercases/sqlite_helper.dart';

class SceneryDao extends SQLiteHelper implements DatasourceFactory {
  int _id = 1;

  int get id => _id;

  @override
  Future<void> createTable() async {
    await open();
    await database.execute('CREATE TABLE IF NOT EXISTS scenery(id INTEGER PRIMARY KEY, description TEXT, expectedResult TEXT, acceptanceCriteria TEXT)');
    close();
  }

  @override
  Future<List<Map<String, Object?>>> find() async {
    await open();
    return await database.rawQuery('select * from scenery').whenComplete(() => close());
  }

  @override
  Future<void> insert(Map<String, Object?> values) async {
    await open();
    await createTable();
    values['id'] = await getLastId();
    _id = await database.insert('scenery', values);
    close();
  }

  @override
  Future<int>? getLastId() async {
    await open();
    List<Map<String, Object?>> value = await database.rawQuery('select id from scenery order by id desc limit 1');

    if (value.isNotEmpty) return (int.parse(value[0]['id'].toString())) + 1;
    return 1;
  }
}
