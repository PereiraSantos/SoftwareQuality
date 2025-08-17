import 'package:flutter/material.dart';
import 'package:software_quality/functionality/component/check_box_scenery.dart';
import 'package:software_quality/functionality/model/functionality.dart';
import 'package:software_quality/functionality/model/functionality_scenery.dart';
import 'package:software_quality/functionality/view_model/functionality_view_model.dart';
import 'package:software_quality/scenery/model/scenery.dart';
import 'package:software_quality/scenery/view_model/scenery_view_model.dart';
import 'package:software_quality/widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterFunctionality extends StatefulWidget {
  RegisterFunctionality({super.key, this.functionality, this.functionalityScenery});

  final Functionality? functionality;
  List<FunctionalityScenery>? functionalityScenery = [];

  @override
  State<RegisterFunctionality> createState() => _RegisterFunctionalityState();
}

class _RegisterFunctionalityState extends State<RegisterFunctionality> {
  final FunctionalityModel functionalityModel = FunctionalityModel();

  @override
  void initState() {
    super.initState();
    functionalityModel.initValues(widget.functionality?.description ?? '', widget.functionality?.observation ?? '', widget.functionality?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextFormFieldWidget(
                controller: functionalityModel.description,
                hintText: 'Descrição',
                minLine: 1,
                maxLine: 5,
                keyboardType: TextInputType.multiline,
                valid: false,
              ),
              TextFormFieldWidget(
                controller: functionalityModel.observation,
                hintText: 'Observação',
                minLine: 1,
                maxLine: 5,
                keyboardType: TextInputType.multiline,
                valid: false,
              ),
              FutureBuilder(
                future: SceneryViewModel().getScenery(widget.functionalityScenery),
                builder: (BuildContext context, AsyncSnapshot<List<Scenery>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            color: Colors.black12,
                            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 2, bottom: 5, top: 8),
                              child: Text('Cenários', style: TextStyle(fontSize: 12)),
                            ),
                          ),
                          ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CheckBoxScenery(
                                scenery: snapshot.data![index],
                                onClick: (value) => functionalityModel.selectScenery(snapshot.data!, index, value),
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
      ),
      floatingActionButton: TextButton(
        onPressed: () async {
          widget.functionality?.id != null
              ? await functionalityModel.updateFunctionality(widget.functionality!.id!)
              : await functionalityModel.registerFunctionality();

          await functionalityModel.registerFunctionalityScenery(widget.functionalityScenery).whenComplete(() {
            functionalityModel.clear();
            widget.functionalityScenery = [];
          });
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
