import 'package:flutter/material.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final List<String> symptoms = [
    'Fever',
    'Cough',
    'Fatigue',
    'Headache',
    'Nausea',
    'Diarrhea',
    'Sore Throat',
    'Muscle Pain',
  ];

  final Set<String> selectedSymptoms = {};
  String predictionResult = '';
  bool isLoading = false;

  void predictDisease() async {
    if (selectedSymptoms.isEmpty) {
      setState(() {
        predictionResult = '⚠️ Please select at least one symptom.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      predictionResult = '';
    });

    await Future.delayed(const Duration(seconds: 2));

    // TODO: Replace with actual API call
    setState(() {
      isLoading = false;
      predictionResult = '🩺 Predicted Disease: Common Cold';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symptom Checker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Select Symptoms:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: symptoms.map((symptom) {
                  return CheckboxListTile(
                    title: Text(symptom),
                    value: selectedSymptoms.contains(symptom),
                    onChanged: (bool? value) {
                      setState(() {
                        value == true
                            ? selectedSymptoms.add(symptom)
                            : selectedSymptoms.remove(symptom);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : predictDisease,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Predict'),
            ),
            const SizedBox(height: 20),
            Text(
              predictionResult,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
