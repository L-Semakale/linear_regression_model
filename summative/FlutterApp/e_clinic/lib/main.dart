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
<<<<<<< HEAD
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
=======
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const HomePage(),
>>>>>>> 27e116cbd55a55735c4229e3a2bf321754c20ebd
    );
  }
}
