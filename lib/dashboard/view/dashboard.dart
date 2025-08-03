import 'package:flutter/material.dart';
import 'package:software_quality/execution/view/list_execution/list_execution_view.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ListExecutionView());
  }
}
