import 'package:software_quality/scenery/datasource/datasource_factory.dart';
import 'package:software_quality/usercases/sqlite_helper.dart';

class PaceDao extends SQLiteHelper implements DatasourceFactory {
  @override
  Future<void> createTable() async {
    await open();
    await database.execute('CREATE TABLE IF NOT EXISTS pace(id INTEGER PRIMARY KEY, description TEXT, idScenery INTEGER)');
    close();
  }

  @override
  Future<List<Map<String, Object?>>> find() async {
    await open();
    return await database.rawQuery('select * from pace').whenComplete(() => close());
  }

  @override
  Future<void> insert(Map<String, Object?> values) async {
    await open();
    await createTable();
    values['id'] = await getLastId();
    await database.insert('pace', values);
    close();
  }

  @override
  Future<int>? getLastId() async {
    await open();
    List<Map<String, Object?>> value = await database.rawQuery('select id from pace order by id desc limit 1');

    if (value.isNotEmpty) return (int.parse(value[0]['id'].toString())) + 1;
    return 1;
  }
}
