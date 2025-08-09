import 'package:flutter/material.dart';
import 'package:software_quality/execution/view/list_execution/list_execution_view.dart';

import 'package:software_quality/widgets/left_drawer.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget child = const ListExecutionView();

  void _update(Widget value) {
    setState(() {
      child = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: LeftDrawer(
              onClick: (value) => _update(value),
            ),
          ),
          Expanded(
            flex: 4,
            child: child,
          ),
        ],
      ),
    );
  }
}
