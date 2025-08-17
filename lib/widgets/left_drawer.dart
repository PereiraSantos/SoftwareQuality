import 'package:flutter/material.dart';
import 'package:software_quality/functionality/view/list/list_functionality_view.dart';
import 'package:software_quality/functionality/view/register/register_functionality.dart';

import 'package:software_quality/scenery/view/list_scenery/list_scenery_view.dart';
import 'package:software_quality/scenery/view/register_scenery/register_scenery_view.dart';
import 'package:software_quality/scope/view/list_scenery/list_scope_view.dart';
import 'package:software_quality/scope/view/register_scenery/register_scope_view.dart';
import 'package:software_quality/usercases/rote/rote.dart';
import 'package:software_quality/usercases/rote/rote_controller.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, required this.roteSelect});
  final String roteSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.grey))),
      child: ListView(
        children: [
          _tile('Escopo', const ListScopeView()),
          _tile('Cadastra Escopo', RegisterScopeView()),
          _tile('Funcionalidade', const ListFunctionalityView()),
          _tile('Cadastra Funcionalidade', RegisterFunctionality()),
          _tile('Cenários', const ListSceneryView()),
          _tile('Cadastra Cenário', const RegisterSceneryView()),
          _tile('Recursos', const SizedBox()),
        ],
      ),
    );
  }

  Widget _tile(String label, Widget child) {
    return Container(
      color: roteSelect == child.runtimeType.toString() ? const Color.fromARGB(255, 225, 225, 225) : null,
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        onTap: () => RoteController.instance.child = Rote(child, true),
      ),
    );
  }
}
