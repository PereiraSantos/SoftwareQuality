import 'package:flutter/material.dart';
import 'package:software_quality/scenery/datasource/pace_dao.dart';
import 'package:software_quality/scenery/datasource/scenery_dao.dart';
import 'package:software_quality/scenery/model/pace.dart';
import 'package:software_quality/scenery/model/scenery.dart';

class SceneryViewModel {
  TextEditingController description = TextEditingController();
  TextEditingController expectedResult = TextEditingController();
  TextEditingController acceptanceCriteria = TextEditingController();
  TextEditingController pace = TextEditingController();
  SceneryDao sceneryDao = SceneryDao();
  PaceDao paceDao = PaceDao();

  List<Pace> paces = [];

  void clearPace() => pace.clear();

  void clear() {
    pace.clear();
    description.clear();
    expectedResult.clear();
    acceptanceCriteria.clear();
    paces.clear();
  }

  Future<void> registerScenery() async {
    await sceneryDao.insert(<String, Object?>{
      'id': null,
      'description': description.text,
      'expectedResult': expectedResult.text,
      'acceptanceCriteria': acceptanceCriteria.text,
    });
  }

  Future<void> registerPace() async {
    for (var e in paces) {
      await paceDao.insert(<String, Object?>{'id': null, 'description': e.description, 'idScenery': sceneryDao.id});
    }
  }

  Future<List<Scenery>> getScenery() async {
    var data = await sceneryDao.find();

    List<Scenery> scenerys = [];

    for (int i = 0; i < data.length; i++) {
      scenerys.add(Scenery(
        id: int.parse(data[i]['id'].toString()),
        description: data[i]['description'].toString(),
        expectedResult: data[i]['expectedResult'].toString(),
        acceptanceCriteria: data[i]['acceptanceCriteria'].toString(),
      ));
    }

    await getPace();

    return scenerys;
  }

  Future<void> getPace() async {
    var data = await paceDao.find();

    for (int i = 0; i < data.length; i++) {
      paces.add(Pace(
        id: int.parse(data[i]['id'].toString()),
        description: data[i]['description'].toString(),
        idScenery: int.parse(data[i]['idScenery'].toString()),
      ));
    }
  }
}
