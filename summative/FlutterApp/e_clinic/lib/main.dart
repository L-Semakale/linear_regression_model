import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const SymptomsCheckerApp());
}

class SymptomsCheckerApp extends StatelessWidget {
  const SymptomsCheckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symptoms AI Checker',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
