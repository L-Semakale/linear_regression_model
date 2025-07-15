import 'package:flutter/material.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final TextEditingController coughController = TextEditingController();
  final TextEditingController feverController = TextEditingController();
  final TextEditingController soreThroatController = TextEditingController();

  String result = '';

  void handlePrediction() {
    if (coughController.text.isEmpty ||
        feverController.text.isEmpty ||
        soreThroatController.text.isEmpty) {
      setState(() {
        result = '❗ Please enter all symptom values.';
      });
    } else {
      setState(() {
        result = '✅ Prediction result will be shown here.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Input'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Symptoms', style: theme.titleLarge),
            const SizedBox(height: 20),

            TextField(
              key: const Key('coughField'),
              controller: coughController,
              decoration: const InputDecoration(
                labelText: 'Cough (e.g., yes/no)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              key: const Key('feverField'),
              controller: feverController,
              decoration: const InputDecoration(
                labelText: 'Fever (e.g., 38.5 or yes)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              key: const Key('soreThroatField'),
              controller: soreThroatController,
              decoration: const InputDecoration(
                labelText: 'Sore Throat (e.g., yes/no)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                key: const Key('predictButton'),
                onPressed: handlePrediction,
                child: const Text('Predict'),
              ),
            ),
            const SizedBox(height: 24),

            Center(
              child: Text(
                result,
                style: TextStyle(
                  fontSize: 16,
                  color: result.startsWith('❗') ? Colors.red : Colors.teal,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
