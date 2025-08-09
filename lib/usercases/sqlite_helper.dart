import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

class SQLiteHelper {
  late Database database;

  Future<void> open() async {
    sqfliteFfiInit();

    var databaseFactory = databaseFactoryFfi;
    final io.Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    String dbPath = p.join(appDocumentsDir.path, "software_quality_database", "software_quality.db");
    database = await databaseFactory.openDatabase(dbPath);
  }

  void close() => database.close();
}
