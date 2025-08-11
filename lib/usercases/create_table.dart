import 'package:software_quality/usercases/sqlite_helper.dart';

class CreateTable {
  SQLiteHelper sqLiteHelper = SQLiteHelper();

  Future<void> createTable() async {
    await _createTablePace();
    await _createTableScenery();
    await _createTableTestBattery();
    await _createTableTestBatteryScenery();
  }

  Future<void> _createTablePace() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database.execute('CREATE TABLE IF NOT EXISTS pace(id INTEGER PRIMARY KEY, description TEXT, idScenery INTEGER)');
    sqLiteHelper.close();
  }

  Future<void> _createTableScenery() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database
        .execute('CREATE TABLE IF NOT EXISTS scenery(id INTEGER PRIMARY KEY, description TEXT, expectedResult TEXT, acceptanceCriteria TEXT)');
    sqLiteHelper.close();
  }

  Future<void> _createTableTestBattery() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database.execute('CREATE TABLE IF NOT EXISTS testBattery(id INTEGER PRIMARY KEY, description TEXT, observation TEXT)');
    sqLiteHelper.close();
  }

  Future<void> _createTableTestBatteryScenery() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database.execute('CREATE TABLE IF NOT EXISTS testBatteryScenery(id INTEGER PRIMARY KEY, idTextBattery INTEGER, idScenery INTEGER)');
    sqLiteHelper.close();
  }
}
