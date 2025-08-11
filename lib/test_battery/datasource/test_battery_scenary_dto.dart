import 'package:software_quality/usercases/datasource_factory.dart';
import 'package:software_quality/usercases/sqlite_helper.dart';

class TestBatteryScenaryDto extends SQLiteHelper implements DatasourceFactory {
  @override
  Future<List<Map<String, Object?>>> find() async {
    await open();
    return await database
        .rawQuery('select tbs.*, ac.description from testBatteryScenery as tbs inner join scenery as ac on ac.id = tbs.idScenery')
        .whenComplete(() => close());
  }

  @override
  Future<void> insert(Map<String, Object?> values) async {
    await open();

    values['id'] = await getLastId();
    await database.insert('testBatteryScenery', values);
    close();
  }

  @override
  Future<int>? getLastId() async {
    await open();
    List<Map<String, Object?>> value = await database.rawQuery('select id from testBatteryScenery order by id desc limit 1');

    if (value.isNotEmpty) return (int.parse(value[0]['id'].toString())) + 1;
    return 1;
  }
}
