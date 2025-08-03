import 'package:flutter/material.dart';
import 'package:software_quality/scenery/component/scenary_card.dart';
import 'package:software_quality/scenery/model/scenery.dart';
import 'package:software_quality/scenery/view/register_scenery/register_scenery_view.dart';
import 'package:software_quality/scenery/view_model/scenery_view_model.dart';
import 'package:software_quality/usercases/to_page_route.dart';

// ignore: must_be_immutable
class ListSceneryView extends StatefulWidget {
  const ListSceneryView({super.key});

  @override
  State<ListSceneryView> createState() => _ListSceneryState();
}

class _ListSceneryState extends State<ListSceneryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SceneryViewModel().getScenery(),
        builder: (BuildContext context, AsyncSnapshot<List<Scenery>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Wrap(
                direction: Axis.horizontal,
                children: [
                  ...snapshot.data!.map((e) {
                    return ScenaryCard(scenery: e);
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
            var result = await Navigator.of(context).push(
              ToPageRoute.createRoute(RegisterSceneryView()),
            );

            if (result) setState(() {});
          },
          child: const Text(
            'Criar cenário',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        )
      ],
    );
  }
}
