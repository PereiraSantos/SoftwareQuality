import 'package:flutter/material.dart';
import 'package:software_quality/usercases/rote/rote_controller.dart';

import 'package:software_quality/widgets/left_drawer.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: RoteController.instance,
        builder: (BuildContext context, Widget? child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: LeftDrawer(roteSelect: RoteController.instance.child.child.toString()),
              ),
              Expanded(
                flex: 4,
                child: RoteController.instance.child.child,
              ),
            ],
          );
        },
      ),
    );
  }
}
