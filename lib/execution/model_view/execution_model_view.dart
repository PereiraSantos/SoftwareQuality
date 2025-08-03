import 'package:flutter/material.dart';
import 'package:software_quality/execution/model/execution.dart';
import 'package:software_quality/scenery/model/scenery.dart';
import 'package:software_quality/usercases/save_file.dart';

class ExecutionModelView {
  TextEditingController description = TextEditingController();
  TextEditingController observation = TextEditingController();
  List<Scenery> scenerys = [];

  void selectScenery(List<Scenery> list, int index, bool? value) {
    scenerys = list;
    scenerys[index].select = value ?? false;
  }

  Future<void> register() async {
    List<Execution> list = await getExecution();

    list.add(Execution(id: list.length + 1, description: description.text, observation: observation.text, scenerys: scenerys));

    List<Map<String, dynamic>> data = [];

    List<Scenery> scenerySelect = scenerys.where((e) => e.select).toList();

    for (var item in list) {
      data.add({
        'id': item.id,
        'description': item.description,
        'observation': item.observation,
        'scenerys': scenerySelect.map((e) => e.description).toList(),
      });
    }

    await SaveFile().writeJsonToFile(data, 'execution.json');
  }

  Future<List<Execution>> getExecution() async {
    List<dynamic>? data = await SaveFile().readJsonFromFile('execution.json');

    if (data == null) return [];

    List<Execution> executions = [];

    for (int i = 0; i < data.length; i++) {
      List<Scenery> scenerys = [];

      for (int j = 0; j < data[i]['scenerys'].length; j++) {
        scenerys.add(Scenery(description: data[i]['scenerys'][j], paces: []));
      }

      executions.add(
        Execution(
          id: data[i]['id'],
          description: data[i]['description'],
          observation: data[i]['observation'],
          scenerys: scenerys,
        ),
      );
    }

    return executions;
  }
}
