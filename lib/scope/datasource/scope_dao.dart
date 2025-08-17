import 'package:software_quality/usercases/datasource_factory.dart';
import 'package:software_quality/usercases/sqlite_helper.dart';

class ScopeDao extends SQLiteHelper implements DatasourceFactory {
  int _id = 1;

  int get id => _id;

  void setId(int value) => _id = value;

  @override
  Future<List<Map<String, Object?>>> find() async {
    await open();
    return await database.rawQuery('''
        select sc.*, 
          (select f.description from functionalityScope as fs inner JOIN  functionality as f on f.id = fs.idFunctionality where idScope = sc.id) as functionalityDescription
          from scope as sc
        ''').whenComplete(() => close());
  }

  @override
  Future<void> insert(Map<String, Object?> values) async {
    await open();
    values['id'] = await getLastId();
    _id = await database.insert('scope', values);
    close();
  }

  @override
  Future<int>? getLastId() async {
    await open();
    List<Map<String, Object?>> value = await database.rawQuery('select id from scope order by id desc limit 1');

    if (value.isNotEmpty) return (int.parse(value[0]['id'].toString())) + 1;
    return 1;
  }

  Future<void> insertFunctionality(Map<String, Object?> values) async {
    await open();
    values['id'] = await getLastFunctionality();
    _id = await database.insert('functionalityScope', values);
    close();
  }

  Future<int>? getLastFunctionality() async {
    await open();
    List<Map<String, Object?>> value = await database.rawQuery('select id from functionalityScope order by id desc limit 1');

    if (value.isNotEmpty) return (int.parse(value[0]['id'].toString())) + 1;
    return 1;
  }

  @override
  Future<void> update(Map<String, Object?> values) async {
    await open();
    await database.update('scope', values, where: 'id = ?', whereArgs: [values['id']]);
    close();
  }

  @override
  Future<void> delete(int id) async {
    await open();
    await database.delete('functionalityScope', where: 'idScope = ?', whereArgs: [id]);
    close();
  }
}
