import 'package:flutter/material.dart';
import 'package:software_quality/functionality/model/functionality_scenery.dart';
import 'package:software_quality/scenery/datasource/scenery_dao.dart';

import 'package:software_quality/scenery/model/scenery.dart';

class SceneryViewModel {
  TextEditingController description = TextEditingController();
  TextEditingController observation = TextEditingController();
  SceneryDao sceneryDao = SceneryDao();

  void initValues(String description, String observation) {
    this.description.text = description;
    this.observation.text = observation;
  }

  void clear() {
    description.clear();
    observation.clear();
  }

  Future<void> registerScenery() async {
    await sceneryDao.insert(<String, Object?>{
      'id': null,
      'description': description.text,
      'observation': observation.text,
    });
  }

  Future<void> updateScenery(int id) async {
    await sceneryDao.update(<String, Object?>{
      'id': id,
      'description': description.text,
      'observation': observation.text,
    });
  }

  Future<List<Scenery>> getScenery([List<FunctionalityScenery>? functionalityScenery]) async {
    var data = await sceneryDao.find();

    List<Scenery> scenerys = [];

    for (int i = 0; i < data.length; i++) {
      scenerys.add(Scenery(
        id: int.parse(data[i]['id'].toString()),
        description: data[i]['description'].toString(),
        observation: data[i]['observation'].toString(),
      ));

      if (functionalityScenery != null) {
        var result = functionalityScenery.where((item) => item.idScenery == scenerys[i].id).toList();
        if (result.isNotEmpty) scenerys[i].select = true;
      }
    }

    return scenerys;
  }
}
