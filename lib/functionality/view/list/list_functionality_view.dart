import 'package:flutter/material.dart';
import 'package:software_quality/functionality/component/functionality_card.dart';
import 'package:software_quality/functionality/model/functionality.dart';
import 'package:software_quality/functionality/view_model/functionality_view_model.dart';

// ignore: must_be_immutable
class ListFunctionalityView extends StatefulWidget {
  const ListFunctionalityView({super.key});

  @override
  State<ListFunctionalityView> createState() => _ListFunctionalityViewState();
}

class _ListFunctionalityViewState extends State<ListFunctionalityView> {
  FunctionalityModel functionalityModel = FunctionalityModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: functionalityModel.getFunctionality(),
          builder: (BuildContext context, AsyncSnapshot<List<Functionality>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Wrap(
                  direction: Axis.horizontal,
                  children: [
                    ...snapshot.data!.map((e) {
                      return FunctionalityCard(
                        functionality: e,
                        functionalityScenery: functionalityModel.functionalityScenery.where((item) => item.idFunctionality == e.id).toList(),
                      );
                    }),
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
      ),
    );
  }
}
