import 'package:flutter/material.dart';
import 'package:software_quality/execution/model/execution.dart';

class CardExecution extends StatelessWidget {
  const CardExecution({super.key, required this.execution});

  final Execution execution;

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
            Text('Descrição: ${execution.description ?? ''}'),
            Text('Observação: ${execution.observation ?? ''}'),
            ...execution.scenerys!.map((e) {
              return Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Cenario: ${e.description ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
