import 'package:flutter/material.dart';
import 'package:software_quality/test_battery/component/card_test_battery.dart';
import 'package:software_quality/test_battery/model/test_battery.dart';
import 'package:software_quality/test_battery/view_model/test_battery_view_model.dart';

class ListTestBattery extends StatelessWidget {
  ListTestBattery({super.key});

  final TestBatteryViewModel testBatteryViewModel = TestBatteryViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: testBatteryViewModel.getTestBattery(),
        builder: (BuildContext context, AsyncSnapshot<List<TestBattery>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Wrap(
                direction: Axis.horizontal,
                children: [
                  ...snapshot.data!.map((e) {
                    return CardTestBattery(
                      testBattery: e,
                      testBatteryScenery: testBatteryViewModel.testBatteryScenerys.where((item) => item.idTextBattery == e.id).toList(),
                    );
                  }),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  "Não há teste!!!",
                  style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w300),
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
