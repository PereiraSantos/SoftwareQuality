import 'package:flutter/material.dart';

import 'package:software_quality/test_battery/model/test_battery.dart';
import 'package:software_quality/test_battery/model/test_battery_scenery.dart';

class CardTestBattery extends StatelessWidget {
  const CardTestBattery({super.key, required this.testBattery, required this.testBatteryScenery});

  final TestBattery testBattery;
  final List<TestBatteryScenery> testBatteryScenery;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 300,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Descrição: ${testBattery.description ?? ''}'),
            Text('Observação: ${testBattery.observation ?? ''}'),
            ListView.builder(
              itemCount: testBatteryScenery.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    'Cenario: ${testBatteryScenery[index].description ?? ''}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
