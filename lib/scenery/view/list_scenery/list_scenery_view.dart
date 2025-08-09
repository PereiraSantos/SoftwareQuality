import 'package:flutter/material.dart';
import 'package:software_quality/scenery/component/scenary_card.dart';
import 'package:software_quality/scenery/model/scenery.dart';
import 'package:software_quality/scenery/view_model/scenery_view_model.dart';

// ignore: must_be_immutable
class ListSceneryView extends StatefulWidget {
  const ListSceneryView({super.key});

  @override
  State<ListSceneryView> createState() => _ListSceneryState();
}

class _ListSceneryState extends State<ListSceneryView> {
  SceneryViewModel sceneryViewModel = SceneryViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: sceneryViewModel.getScenery(),
          builder: (BuildContext context, AsyncSnapshot<List<Scenery>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Wrap(
                  direction: Axis.horizontal,
                  children: [
                    ...snapshot.data!.map((e) {
                      return ScenaryCard(
                        scenery: e,
                        paces: sceneryViewModel.paces.where((item) => item.idScenery == e.id).toList(),
                      );
                    }),
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
      ),
    );
  }
}
