import 'package:flutter/material.dart';
import 'package:software_quality/functionality/model/functionality.dart';
import 'package:software_quality/functionality/view_model/functionality_view_model.dart';
import 'package:software_quality/scope/component/functionality_checkbox.dart';
import 'package:software_quality/scope/component/register_pace.dart';
import 'package:software_quality/scope/model/pace.dart';
import 'package:software_quality/scope/model/scope.dart';
import 'package:software_quality/scope/view_model/scope_view_model.dart';
import 'package:software_quality/widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterScopeView extends StatefulWidget {
  RegisterScopeView({super.key, this.scope, this.paces});
  Scope? scope;
  final List<Pace>? paces;

  @override
  State<RegisterScopeView> createState() => _RegisterScopeViewState();
}

class _RegisterScopeViewState extends State<RegisterScopeView> {
  ScopeViewModel scopeViewModel = ScopeViewModel();

  @override
  void initState() {
    super.initState();
    scopeViewModel.initValues(
      widget.scope?.description ?? '',
      widget.scope?.observation ?? '',
      widget.scope?.expectedResult ?? '',
      widget.scope?.acceptanceCriteriy ?? '',
      widget.paces ?? [],
      widget.scope?.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldWidget(
                controller: scopeViewModel.description,
                hintText: 'Escope',
                minLine: 1,
                maxLine: 5,
                keyboardType: TextInputType.multiline,
                valid: false,
              ),
              TextFormFieldWidget(
                controller: scopeViewModel.observation,
                hintText: 'Observação',
                minLine: 1,
                maxLine: 5,
                keyboardType: TextInputType.multiline,
                valid: false,
              ),
              FutureBuilder(
                future: FunctionalityModel().getFunctionality(widget.scope?.functionalityDescription),
                builder: (BuildContext context, AsyncSnapshot<List<Functionality>> snapshot) {
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
                              child: Text('Funcionalidades', style: TextStyle(fontSize: 12)),
                            ),
                          ),
                          FunctionalityCheckbox(functionality: snapshot.data!, scopeViewModel: scopeViewModel),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "Não há funcionalidades!!!",
                          style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w300),
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
              TextFormFieldWidget(
                controller: scopeViewModel.pace,
                hintText: 'Pasos',
                keyboardType: TextInputType.text,
                valid: false,
              ),
              RegisterPace(scopeViewModel: scopeViewModel),
              TextFormFieldWidget(
                controller: scopeViewModel.expectedResult,
                hintText: 'Resultado esperado',
                minLine: 1,
                maxLine: 5,
                keyboardType: TextInputType.multiline,
                valid: false,
              ),
              TextFormFieldWidget(
                controller: scopeViewModel.acceptanceCriteriy,
                hintText: 'Critério de aceitação',
                minLine: 1,
                maxLine: 5,
                keyboardType: TextInputType.multiline,
                valid: false,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () async {
          if (scopeViewModel.description.text == '') return;

          widget.scope?.id != null ? await scopeViewModel.updateScope(widget.scope!.id!) : await scopeViewModel.registerScope();
          widget.scope?.id != null && widget.scope?.functionalityDescription != ''
              ? await scopeViewModel.updateFunctionality()
              : await scopeViewModel.registerFunctionality();

          if (widget.scope?.id == null) await scopeViewModel.registerPace();
          scopeViewModel.clear();
          widget.scope = null;
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
