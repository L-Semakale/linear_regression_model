import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
