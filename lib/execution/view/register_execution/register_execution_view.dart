import 'package:flutter/material.dart';
import 'package:software_quality/execution/component/check_box_scenery.dart';
import 'package:software_quality/execution/model_view/execution_model_view.dart';
import 'package:software_quality/scenery/model/scenery.dart';
import 'package:software_quality/scenery/view_model/scenery_view_model.dart';
import 'package:software_quality/widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterExecutionView extends StatelessWidget {
  RegisterExecutionView({super.key});

  ExecutionModelView executionModelView = ExecutionModelView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            TextFormFieldWidget(
              controller: executionModelView.description,
              hintText: 'Descrição',
              keyboardType: TextInputType.text,
              textArea: false,
              valid: false,
            ),
            TextFormFieldWidget(
              controller: executionModelView.observation,
              hintText: 'Observação',
              keyboardType: TextInputType.text,
              textArea: false,
              valid: false,
            ),
            FutureBuilder(
              future: SceneryViewModel().getScenery(),
              builder: (BuildContext context, AsyncSnapshot<List<Scenery>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          child: Text('Cenários'),
                        ),
                        ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CheckBoxScenery(
                              scenery: snapshot.data![index],
                              onClick: (value) => executionModelView.selectScenery(snapshot.data!, index, value),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Não há cenários!!!",
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
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () async {
          await executionModelView.register();
        },
        child: const Text(
          'SALVAR',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
