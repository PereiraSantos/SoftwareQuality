import 'package:flutter/material.dart';

import 'package:software_quality/scenery/view/list_scenery/list_scenery_view.dart';
import 'package:software_quality/scenery/view/register_scenery/register_scenery_view.dart';
import 'package:software_quality/test_battery/view/list_test_battery/list_test_battery.dart';
import 'package:software_quality/test_battery/view/register_test_battery/register_test_battery.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, required this.onClick});

  final Function(Widget) onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.grey))),
      child: ListView(
        children: [
          _tile('Testes', ListTestBattery()),
          _tile('Cadastra Teste', const RegisterTestBattery()),
          _tile('Cenários', const ListSceneryView()),
          _tile('Cadastra Cenário', const RegisterSceneryView()),
        ],
      ),
    );
  }

  Widget _tile(String label, Widget child) {
    return ListTile(
      title: Text(label),
      onTap: () => onClick(child),
    );
  }
}
