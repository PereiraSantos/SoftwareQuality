import 'package:flutter/material.dart';
import 'package:software_quality/execution/component/card_execution.dart';
import 'package:software_quality/execution/model/execution.dart';
import 'package:software_quality/execution/model_view/execution_model_view.dart';

class ListExecutionView extends StatefulWidget {
  const ListExecutionView({super.key});

  @override
  State<ListExecutionView> createState() => _ListExecutionViewState();
}

class _ListExecutionViewState extends State<ListExecutionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ExecutionModelView().getExecution(),
        builder: (BuildContext context, AsyncSnapshot<List<Execution>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Wrap(
                direction: Axis.horizontal,
                children: [
                  ...snapshot.data!.map((e) {
                    return CardExecution(execution: e);
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
