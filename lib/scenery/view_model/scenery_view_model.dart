import 'package:flutter/material.dart';
import 'package:software_quality/scenery/model/pace.dart';
import 'package:software_quality/scenery/model/scenery.dart';
import 'package:software_quality/usercases/save_file.dart';

class SceneryViewModel {
  TextEditingController description = TextEditingController();
  TextEditingController expectedResult = TextEditingController();
  TextEditingController acceptanceCriteria = TextEditingController();
  TextEditingController pace = TextEditingController();

  List<Pace> paces = [];

  void clearPace() => pace.clear();

  Future<void> register() async {
    List<Scenery> list = await getScenery();

    list.add(Scenery(
      id: list.length + 1,
      description: description.text,
      expectedResult: expectedResult.text,
      acceptanceCriteria: acceptanceCriteria.text,
      paces: paces,
    ));

    List<Map<String, dynamic>> data = [];

    for (var item in list) {
      data.add({
        'id': item.id,
        'description': item.description,
        'expectedResult': item.expectedResult,
        'acceptanceCriteria': item.acceptanceCriteria,
        'paces': item.paces.map((e) => e.description).toList()
      });
    }

    await SaveFile().writeJsonToFile(data, 'scenery.json');
  }

  Future<List<Scenery>> getScenery() async {
    List<dynamic>? data = await SaveFile().readJsonFromFile('scenery.json');

    if (data == null) return [];

    List<Scenery> scenerys = [];

    for (int i = 0; i < data.length; i++) {
      List<Pace> paces = [];

      for (int j = 0; j < data[i]['paces'].length; j++) {
        paces.add(Pace(description: data[i]['paces'][j]));
      }

      scenerys.add(Scenery(
        id: data[i]['id'],
        description: data[i]['description'],
        expectedResult: data[i]['expectedResult'],
        acceptanceCriteria: data[i]['acceptanceCriteria'],
        paces: paces,
      ));
    }

    return scenerys;
  }
}
