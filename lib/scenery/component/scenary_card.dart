import 'package:flutter/material.dart';
import 'package:software_quality/scenery/model/scenery.dart';

// ignore: must_be_immutable
class ScenaryCard extends StatelessWidget {
  ScenaryCard({super.key, required this.scenery});

  final Scenery scenery;
  int i = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 400,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Cenário: ${scenery.description ?? ''}'),
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Divider(
                height: 1,
              ),
            ),
            ...scenery.paces.map((e) {
              return Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Passo ${i++}: ${e.description ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              );
            }),
            const Padding(padding: EdgeInsets.all(5)),
            Text('Resultado esperado: ${scenery.expectedResult ?? ''}'),
            Text('Critério de aceitação: ${scenery.acceptanceCriteria ?? ''}'),
          ],
        ),
      ),
    );
  }
}
