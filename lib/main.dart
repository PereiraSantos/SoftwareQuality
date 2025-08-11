import 'package:flutter/material.dart';
import 'package:software_quality/dashboard/view/dashboard.dart';
import 'package:software_quality/usercases/create_table.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CreateTable().createTable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const Dashboard(),
    );
  }
}
