import 'package:flutter/material.dart';

import 'package:software_quality/scope/model/pace.dart';
import 'package:software_quality/scope/model/scope.dart';
import 'package:software_quality/scope/view/register_scenery/register_scope_view.dart';
import 'package:software_quality/usercases/rote/rote.dart';
import 'package:software_quality/usercases/rote/rote_controller.dart';
import 'package:software_quality/widgets/button_edit.dart';

// ignore: must_be_immutable
class ScopeCard extends StatelessWidget {
  ScopeCard({super.key, required this.scope, required this.paces});

  final Scope scope;
  final List<Pace> paces;
  int i = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 240,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    'Escopo: ${scope.description ?? ''}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Expanded(
                  child: ButtonEdit(
                    onTap: () => RoteController.instance.child = Rote(
                      RegisterScopeView(
                        scope: scope,
                        paces: paces,
                      ),
                      true,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Observação: ${scope.observation ?? ''}',
              style: const TextStyle(fontSize: 12),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Divider(
                height: 1,
              ),
            ),
            Text(
              'Funcionalidade: ${scope.functionalityDescription ?? ''}',
              style: const TextStyle(fontSize: 12),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Divider(
                height: 1,
              ),
            ),
            ListView.builder(
              itemCount: paces.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Text(
                  'Passo ${i++}: ${paces[index].description ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Text(
              'Resultado esperado: ${scope.expectedResult ?? ''}',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              'Critério de aceitação: ${scope.acceptanceCriteriy ?? ''}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
