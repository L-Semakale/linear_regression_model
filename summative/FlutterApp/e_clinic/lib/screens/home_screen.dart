import 'package:flutter/material.dart';
import 'prediction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptoms AI Checker'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          key: const Key('startButton'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PredictionScreen()),
            );
          },
          child: const Text('Start Symptom Check'),
        ),
      ),
    );
  }
}
