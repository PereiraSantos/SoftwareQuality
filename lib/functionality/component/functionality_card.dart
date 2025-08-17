import 'package:flutter/material.dart';
import 'package:software_quality/functionality/model/functionality.dart';
import 'package:software_quality/functionality/model/functionality_scenery.dart';
import 'package:software_quality/functionality/view/register/register_functionality.dart';
import 'package:software_quality/usercases/rote/rote.dart';
import 'package:software_quality/usercases/rote/rote_controller.dart';
import 'package:software_quality/widgets/button_edit.dart';

class FunctionalityCard extends StatelessWidget {
  const FunctionalityCard({super.key, required this.functionality, required this.functionalityScenery});

  final Functionality functionality;
  final List<FunctionalityScenery> functionalityScenery;

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
                    'Descrição: ${functionality.description ?? ''}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Expanded(
                  child: ButtonEdit(
                    onTap: () => RoteController.instance.child = Rote(
                      RegisterFunctionality(
                        functionality: functionality,
                        functionalityScenery: functionalityScenery,
                      ),
                      true,
                    ),
                  ),
                )
              ],
            ),
            Text('Observação: ${functionality.observation ?? ''}', style: const TextStyle(fontSize: 12)),
            Visibility(
              visible: functionalityScenery.isNotEmpty,
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                color: Colors.black12,
                child: const Text(
                  'Cenario',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            ListView.builder(
              itemCount: functionalityScenery.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    functionalityScenery[index].description ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 12),
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
