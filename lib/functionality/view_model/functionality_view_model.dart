import 'package:flutter/material.dart';
import 'package:software_quality/functionality/datasource/functionality_dto.dart';
import 'package:software_quality/functionality/datasource/functionality_scenary_dto.dart';
import 'package:software_quality/functionality/model/functionality.dart';
import 'package:software_quality/functionality/model/functionality_scenery.dart';
import 'package:software_quality/scenery/model/scenery.dart';

class FunctionalityModel {
  TextEditingController description = TextEditingController();
  TextEditingController observation = TextEditingController();
  List<Scenery> scenerys = [];
  List<FunctionalityScenery> functionalityScenery = [];

  FunctionalityDto functionalityDto = FunctionalityDto();
  FunctionalityScenaryDto functionalityScenaryDto = FunctionalityScenaryDto();

  void initValues(String description, String observation, int? id) {
    this.description.text = description;
    this.observation.text = observation;
    if (id != null) functionalityDto.setId(id);
  }

  void clear() {
    description.clear();
    observation.clear();
  }

  void selectScenery(List<Scenery> list, int index, bool? value) {
    scenerys = list;
    scenerys[index].select = value ?? false;
  }

  Future<void> registerFunctionality() async {
    await functionalityDto.insert(<String, Object?>{
      'id': null,
      'description': description.text,
      'observation': observation.text,
    });
  }

  Future<void> updateFunctionality(int id) async {
    await functionalityDto.update(<String, Object?>{
      'id': id,
      'description': description.text,
      'observation': observation.text,
    });
  }

  Future<void> registerFunctionalityScenery(List<FunctionalityScenery>? functionalityScenery) async {
    if (functionalityScenery != null) {
      for (var item in functionalityScenery) {
        await functionalityScenaryDto.delete(item.id!);
      }
    }

    for (var e in scenerys) {
      if (e.select) await functionalityScenaryDto.insert(<String, Object?>{'id': null, 'idFunctionality': functionalityDto.id, 'idScenery': e.id});
    }
  }

  Future<List<Functionality>> getFunctionality([String? functionalityDescription]) async {
    var data = await functionalityDto.find();

    List<Functionality> functionalitys = [];

    for (int i = 0; i < data.length; i++) {
      functionalitys.add(
        Functionality(
          id: int.parse(data[i]['id'].toString()),
          description: data[i]['description'].toString(),
          observation: data[i]['observation'].toString(),
        ),
      );

      if (functionalityDescription == functionalitys[i].description) functionalitys[i].select = true;
    }

    await getFunctionalityScenery();

    return functionalitys;
  }

  Future<void> getFunctionalityScenery() async {
    var data = await functionalityScenaryDto.find();

    for (int i = 0; i < data.length; i++) {
      functionalityScenery.add(
        FunctionalityScenery(
            id: int.parse(data[i]['id'].toString()),
            idScenery: int.parse(data[i]['idScenery'].toString()),
            idFunctionality: int.parse(data[i]['idFunctionality'].toString()),
            description: data[i]['description'].toString()),
      );
    }
  }
}
