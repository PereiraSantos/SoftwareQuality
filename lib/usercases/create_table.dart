import 'package:software_quality/usercases/sqlite_helper.dart';

class CreateTable {
  SQLiteHelper sqLiteHelper = SQLiteHelper();

  Future<void> createTable() async {
    await _createTableScope();
    await _createTablePace();
    await _createTableFunctionalityScope();
    await _createTableScenery();
    await _createTableFunctionality();
    await _createTableFunctionalityScenery();
  }

  Future<void> _createTableScope() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database
        .execute('CREATE TABLE IF NOT EXISTS scope(id INTEGER PRIMARY KEY, description TEXT, observation TEXT,expectedResult TEXT, acceptanceCriteriy TEXT)');
    sqLiteHelper.close();
  }

  Future<void> _createTableFunctionalityScope() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database.execute('CREATE TABLE IF NOT EXISTS functionalityScope(id INTEGER PRIMARY KEY, idScope INTEGER, idFunctionality INTEGER)');
    sqLiteHelper.close();
  }

  Future<void> _createTablePace() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database.execute('CREATE TABLE IF NOT EXISTS pace(id INTEGER PRIMARY KEY, description TEXT, idScenery INTEGER)');
    sqLiteHelper.close();
  }

  Future<void> _createTableScenery() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database.execute('CREATE TABLE IF NOT EXISTS scenery(id INTEGER PRIMARY KEY, description TEXT, observation TEXT)');
    sqLiteHelper.close();
  }

  Future<void> _createTableFunctionality() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database.execute('CREATE TABLE IF NOT EXISTS functionality(id INTEGER PRIMARY KEY, description TEXT, observation TEXT)');
    sqLiteHelper.close();
  }

  Future<void> _createTableFunctionalityScenery() async {
    await sqLiteHelper.open();
    await sqLiteHelper.database.execute('CREATE TABLE IF NOT EXISTS functionalityScenery(id INTEGER PRIMARY KEY, idFunctionality INTEGER, idScenery INTEGER)');
    sqLiteHelper.close();
  }
}
