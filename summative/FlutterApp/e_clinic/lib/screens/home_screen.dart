import 'package:flutter/material.dart';
import 'prediction_screen.dart'; // ✅ Ensure the correct relative path

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptoms AI Checker')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PredictionScreen()),
            );
          },
          child: const Text('Start Symptom Check'),
        ),
      ),
    );
  }
}
