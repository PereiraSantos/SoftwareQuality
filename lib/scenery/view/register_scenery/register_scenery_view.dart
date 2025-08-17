import 'package:flutter/material.dart';
import 'package:software_quality/scenery/model/scenery.dart';

import 'package:software_quality/scenery/view_model/scenery_view_model.dart';
import 'package:software_quality/widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterSceneryView extends StatefulWidget {
  const RegisterSceneryView({super.key, this.scenery});
  final Scenery? scenery;

  @override
  State<RegisterSceneryView> createState() => _RegisterSceneryViewState();
}

class _RegisterSceneryViewState extends State<RegisterSceneryView> {
  SceneryViewModel sceneryViewModel = SceneryViewModel();

  @override
  void initState() {
    super.initState();
    sceneryViewModel.initValues(widget.scenery?.description ?? '', widget.scenery?.observation ?? '');
  }

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
              hintText: 'Descrição',
              minLine: 1,
              maxLine: 5,
              keyboardType: TextInputType.multiline,
              valid: false,
            ),
            TextFormFieldWidget(
              controller: sceneryViewModel.observation,
              hintText: 'Observação',
              minLine: 1,
              maxLine: 5,
              keyboardType: TextInputType.multiline,
              valid: false,
            ),
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () async {
          if (sceneryViewModel.description.text == '') return;

          widget.scenery?.id != null ? await sceneryViewModel.updateScenery(widget.scenery!.id!) : await sceneryViewModel.registerScenery();
          sceneryViewModel.clear();
          setState(() {});
        },
        child: const Text(
          'SALVAR',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
