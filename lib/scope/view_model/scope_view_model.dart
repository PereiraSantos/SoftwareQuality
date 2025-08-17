import 'package:flutter/material.dart';
import 'package:software_quality/functionality/datasource/functionality_dto.dart';
import 'package:software_quality/functionality/model/functionality.dart';
import 'package:software_quality/scenery/datasource/pace_dao.dart';
import 'package:software_quality/scope/datasource/scope_dao.dart';
import 'package:software_quality/scope/model/pace.dart';
import 'package:software_quality/scope/model/scope.dart';

class ScopeViewModel {
  TextEditingController description = TextEditingController();
  TextEditingController observation = TextEditingController();
  TextEditingController expectedResult = TextEditingController();
  TextEditingController acceptanceCriteriy = TextEditingController();
  TextEditingController pace = TextEditingController();
  ScopeDao scopeDao = ScopeDao();
  PaceDao paceDao = PaceDao();
  FunctionalityDto functionalityDto = FunctionalityDto();

  List<Pace> paces = [];
  Functionality? functionalitysSelect;
  List<Functionality> functionalitys = [];

  void initValues(String description, String observation, String expectedResult, String acceptanceCriteriy, List<Pace> paces, [int? id]) {
    this.description.text = description;
    this.observation.text = observation;
    this.expectedResult.text = expectedResult;
    this.acceptanceCriteriy.text = acceptanceCriteriy;
    this.paces = paces;
    if (id != null) scopeDao.setId(id);
  }

  void selectFunctionality(List<Functionality> list, int index, bool? value) {
    for (int i = 0; i < list.length; i++) {
      list[i].select = false;
    }

    list[index].select = value ?? false;

    functionalitys = list;

    functionalitysSelect = list[index];
  }

  void clearPace() => pace.clear();

  void clear() {
    pace.clear();
    description.clear();
    observation.clear();
    expectedResult.clear();

    acceptanceCriteriy.clear();
    paces.clear();
    functionalitysSelect = null;
  }

  Future<void> registerScope() async {
    await scopeDao.insert(<String, Object?>{
      'id': null,
      'description': description.text,
      'observation': observation.text,
      'expectedResult': expectedResult.text,
      'acceptanceCriteriy': acceptanceCriteriy.text,
    });
  }

  Future<void> updateScope(int id) async {
    await scopeDao.update(<String, Object?>{
      'id': id,
      'description': description.text,
      'observation': observation.text,
      'expectedResult': expectedResult.text,
      'acceptanceCriteriy': acceptanceCriteriy.text,
    });
  }

  Future<void> registerFunctionality() async {
    if (functionalitysSelect == null) return;

    await scopeDao.insertFunctionality(
      <String, Object?>{
        'id': null,
        'idScope': scopeDao.id,
        'idFunctionality': functionalitysSelect!.id,
      },
    );
  }

  Future<void> updateFunctionality() async {
    await scopeDao.delete(scopeDao.id);

    if (functionalitysSelect != null && functionalitysSelect!.select) {
      await scopeDao.insertFunctionality(
        <String, Object?>{
          'id': null,
          'idScope': scopeDao.id,
          'idFunctionality': functionalitysSelect!.id,
        },
      );
    }
  }

  Future<void> registerPace() async {
    for (var e in paces) {
      await paceDao.insert(<String, Object?>{'id': null, 'description': e.description, 'idScenery': scopeDao.id});
    }
  }

  Future<List<Scope>> getScope() async {
    var data = await scopeDao.find();

    List<Scope> scope = [];

    for (int i = 0; i < data.length; i++) {
      scope.add(Scope(
        id: int.parse(data[i]['id'].toString()),
        description: data[i]['description'].toString(),
        observation: data[i]['observation'].toString(),
        expectedResult: data[i]['expectedResult'].toString(),
        acceptanceCriteriy: data[i]['acceptanceCriteriy'].toString(),
        functionalityDescription: data[i]['functionalityDescription'] != null ? data[i]['functionalityDescription'].toString() : '',
      ));
    }

    await getPace();

    return scope;
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
