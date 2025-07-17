import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _symptomController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  String _predictionResult = '';

  Future<void> predictDisease() async {
    final url = Uri.parse(
        "http://127.0.0.1:5000/predict"); // use your server IP if testing on mobile

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Age": int.tryParse(_ageController.text) ?? 0,
        "Symptoms": _symptomController.text,
        "Region": _regionController.text,
        "Gender": _genderController.text,
        // Add other fields as needed
      }),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      setState(() {
        _predictionResult = decoded['prediction'].toString();
      });
    } else {
      setState(() {
        _predictionResult = 'Error: ${response.reasonPhrase}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Disease Prediction")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _symptomController,
                decoration: const InputDecoration(labelText: 'Symptoms'),
              ),
              TextFormField(
                controller: _regionController,
                decoration: const InputDecoration(labelText: 'Region'),
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender (M/F)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: predictDisease,
                child: const Text('Predict'),
              ),
              const SizedBox(height: 20),
              Text(
                _predictionResult.isEmpty
                    ? 'Prediction will appear here'
                    : 'Prediction: $_predictionResult',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
