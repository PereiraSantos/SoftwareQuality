import 'package:software_quality/usercases/datasource_factory.dart';
import 'package:software_quality/usercases/sqlite_helper.dart';

class SceneryDao extends SQLiteHelper implements DatasourceFactory {
  int _id = 1;

  int get id => _id;

  @override
  Future<List<Map<String, Object?>>> find() async {
    await open();
    return await database.rawQuery('select * from scenery').whenComplete(() => close());
  }

  @override
  Future<void> insert(Map<String, Object?> values) async {
    await open();
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
