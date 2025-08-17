import 'package:software_quality/usercases/datasource_factory.dart';
import 'package:software_quality/usercases/sqlite_helper.dart';

class FunctionalityDto extends SQLiteHelper implements DatasourceFactory {
  int _id = 1;

  int get id => _id;

  void setId(int value) => _id = value;

  @override
  Future<List<Map<String, Object?>>> find() async {
    await open();
    return await database.rawQuery('select * from functionality').whenComplete(() => close());
  }

  @override
  Future<void> insert(Map<String, Object?> values) async {
    await open();
    values['id'] = await getLastId();
    _id = await database.insert('functionality', values);
    close();
  }

  @override
  Future<int>? getLastId() async {
    await open();
    List<Map<String, Object?>> value = await database.rawQuery('select id from functionality order by id desc limit 1');

    if (value.isNotEmpty) return (int.parse(value[0]['id'].toString())) + 1;
    return 1;
  }

  @override
  Future<void> update(Map<String, Object?> values) async {
    await open();
    await database.update('functionality', values, where: 'id = ?', whereArgs: [values['id']]);
    close();
  }

  @override
  Future<void> delete(int id) async {}
}
