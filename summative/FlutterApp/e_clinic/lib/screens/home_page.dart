import 'package:flutter/material.dart';
import 'package:e_clinic/screens/prediction_page.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              MaterialPageRoute(builder: (context) => const PredictionPage()),
            );
          },
          child: const Text('Start Symptom Check'),
        ),
      ),
    );
  }
}
