import 'package:flutter/material.dart';

import 'package:software_quality/scope/component/scope_card.dart';
import 'package:software_quality/scope/model/scope.dart';
import 'package:software_quality/scope/view_model/scope_view_model.dart';

// ignore: must_be_immutable
class ListScopeView extends StatefulWidget {
  const ListScopeView({super.key});

  @override
  State<ListScopeView> createState() => _ListSceopeViewState();
}

class _ListSceopeViewState extends State<ListScopeView> {
  ScopeViewModel scopeViewModel = ScopeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: scopeViewModel.getScope(),
          builder: (BuildContext context, AsyncSnapshot<List<Scope>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Wrap(
                  direction: Axis.horizontal,
                  children: [
                    ...snapshot.data!.map((e) {
                      return ScopeCard(
                        scope: e,
                        paces: scopeViewModel.paces.where((item) => item.idScenery == e.id).toList(),
                      );
                    }),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "Não há escopo!!!",
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
      ),
    );
  }
}
