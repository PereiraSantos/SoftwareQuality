import 'package:flutter/material.dart';
import 'package:software_quality/execution/view/list_execution/list_execution_view.dart';
import 'package:software_quality/execution/view/register_execution/register_execution_view.dart';
import 'package:software_quality/scenery/view/list_scenery/list_scenery_view.dart';
import 'package:software_quality/scenery/view/register_scenery/register_scenery_view.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, required this.onClick});

  final Function(Widget) onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.grey))),
      child: ListView(
        children: [
          _tile('Testes', const ListExecutionView()),
          _tile('Cadastra Teste', RegisterExecutionView()),
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
