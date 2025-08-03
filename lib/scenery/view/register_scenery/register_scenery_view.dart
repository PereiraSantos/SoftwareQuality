import 'package:flutter/material.dart';
import 'package:software_quality/scenery/component/register_pace.dart';

import 'package:software_quality/scenery/view_model/scenery_view_model.dart';
import 'package:software_quality/widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterSceneryView extends StatelessWidget {
  RegisterSceneryView({super.key});
  SceneryViewModel sceneryViewModel = SceneryViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormFieldWidget(
              controller: sceneryViewModel.description,
              hintText: 'Cenário',
              keyboardType: TextInputType.text,
              textArea: false,
              valid: false,
            ),
            TextFormFieldWidget(
              controller: sceneryViewModel.pace,
              hintText: 'Pasos',
              keyboardType: TextInputType.text,
              textArea: true,
              valid: false,
            ),
            RegisterPace(sceneryViewModel: sceneryViewModel),
            TextFormFieldWidget(
              controller: sceneryViewModel.expectedResult,
              hintText: 'Resultado esperado',
              keyboardType: TextInputType.text,
              textArea: true,
              valid: false,
            ),
            TextFormFieldWidget(
              controller: sceneryViewModel.acceptanceCriteria,
              hintText: 'Critério de aceitação',
              keyboardType: TextInputType.text,
              textArea: true,
              valid: false,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () async => Navigator.pop(context, true),
          child: const Text(
            'Voltar',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (sceneryViewModel.description.text == '') return;

            await sceneryViewModel.register();

            // ignore: use_build_context_synchronously
            Navigator.pop(context, true);
          },
          child: const Text(
            'SALVAR',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        )
      ],
    );
  }
}
