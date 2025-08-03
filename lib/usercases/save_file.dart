import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class SaveFile {
  Future<File> writeJsonToFile(List<Map<String, dynamic>> jsonData, String filename) async {
    final file = await _localFile(filename);
    return file.writeAsString(json.encode(jsonData));
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File(p.join(path, filename));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<List<dynamic>?> readJsonFromFile(String filename) async {
    try {
      final file = await _localFile(filename);
      final contents = await file.readAsString();
      return json.decode(contents) as List<dynamic>;
    } catch (e) {
      return null;
    }
  }
}
