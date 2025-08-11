import 'package:flutter/material.dart';
import 'package:software_quality/scenery/model/scenery.dart';
import 'package:software_quality/test_battery/datasource/test_battery_dto.dart';
import 'package:software_quality/test_battery/datasource/test_battery_scenary_dto.dart';
import 'package:software_quality/test_battery/model/test_battery.dart';
import 'package:software_quality/test_battery/model/test_battery_scenery.dart';

class TestBatteryViewModel {
  TextEditingController description = TextEditingController();
  TextEditingController observation = TextEditingController();
  List<Scenery> scenerys = [];
  List<TestBatteryScenery> testBatteryScenerys = [];

  TestBatteryDto testBatteryDto = TestBatteryDto();
  TestBatteryScenaryDto testBatteryScenaryDto = TestBatteryScenaryDto();

  void clear() {
    description.clear();
    observation.clear();
  }

  void selectScenery(List<Scenery> list, int index, bool? value) {
    scenerys = list;
    scenerys[index].select = value ?? false;
  }

  Future<void> registerTestBattery() async {
    await testBatteryDto.insert(<String, Object?>{
      'id': null,
      'description': description.text,
      'observation': observation.text,
    });
  }

  Future<void> registerTestBatteryScenery() async {
    for (var e in scenerys) {
      if (e.select) await testBatteryScenaryDto.insert(<String, Object?>{'id': null, 'idTextBattery': testBatteryDto.id, 'idScenery': e.id});
    }
  }

  Future<List<TestBattery>> getTestBattery() async {
    var data = await testBatteryDto.find();

    List<TestBattery> testBatterys = [];

    for (int i = 0; i < data.length; i++) {
      testBatterys.add(TestBattery(
        id: int.parse(data[i]['id'].toString()),
        description: data[i]['description'].toString(),
        observation: data[i]['observation'].toString(),
      ));
    }

    await getTestBatteryScenery();

    return testBatterys;
  }

  Future<void> getTestBatteryScenery() async {
    var data = await testBatteryScenaryDto.find();

    for (int i = 0; i < data.length; i++) {
      testBatteryScenerys.add(
        TestBatteryScenery(
            id: int.parse(data[i]['id'].toString()),
            idScenery: int.parse(data[i]['idScenery'].toString()),
            idTextBattery: int.parse(data[i]['idTextBattery'].toString()),
            description: data[i]['description'].toString()),
      );
    }
  }
}
