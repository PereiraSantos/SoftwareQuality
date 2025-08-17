import 'package:software_quality/usercases/datasource_factory.dart';
import 'package:software_quality/usercases/sqlite_helper.dart';

class FunctionalityScenaryDto extends SQLiteHelper implements DatasourceFactory {
  @override
  Future<List<Map<String, Object?>>> find() async {
    await open();
    return await database
        .rawQuery('select tbs.*, ac.description from functionalityScenery as tbs inner join scenery as ac on ac.id = tbs.idScenery')
        .whenComplete(() => close());
  }

  @override
  Future<void> insert(Map<String, Object?> values) async {
    await open();

    values['id'] = await getLastId();
    await database.insert('functionalityScenery', values);
    close();
  }

  @override
  Future<int>? getLastId() async {
    await open();
    List<Map<String, Object?>> value = await database.rawQuery('select id from functionalityScenery order by id desc limit 1');

    if (value.isNotEmpty) return (int.parse(value[0]['id'].toString())) + 1;
    return 1;
  }

  @override
  Future<void> update(Map<String, Object?> values) async {
    await open();
    await database.update('functionalityScenery', values, where: 'id = ?', whereArgs: [values['id']]);
    close();
  }

  @override
  Future<void> delete(int id) async {
    await open();
    database.delete('functionalityScenery', where: 'id = ?', whereArgs: [id]);
    close();
  }
}
