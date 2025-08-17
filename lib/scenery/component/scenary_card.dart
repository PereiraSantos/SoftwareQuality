import 'package:flutter/material.dart';

import 'package:software_quality/scenery/model/scenery.dart';
import 'package:software_quality/scenery/view/register_scenery/register_scenery_view.dart';
import 'package:software_quality/usercases/rote/rote.dart';
import 'package:software_quality/usercases/rote/rote_controller.dart';
import 'package:software_quality/widgets/button_edit.dart';

// ignore: must_be_immutable
class ScenaryCard extends StatelessWidget {
  const ScenaryCard({super.key, required this.scenery});

  final Scenery scenery;

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
                    'Cenário: ${scenery.description ?? ''}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Expanded(
                  child: ButtonEdit(
                    onTap: () => RoteController.instance.child = Rote(RegisterSceneryView(scenery: scenery), true),
                  ),
                )
              ],
            ),
            Text(
              'Obsevação: ${scenery.observation ?? ''}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
