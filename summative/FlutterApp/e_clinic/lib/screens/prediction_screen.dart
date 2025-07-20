import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController pregnancies = TextEditingController();
  final TextEditingController glucose = TextEditingController();
  final TextEditingController bloodPressure = TextEditingController();
  final TextEditingController skinThickness = TextEditingController();
  final TextEditingController insulin = TextEditingController();
  final TextEditingController bmi = TextEditingController();
  final TextEditingController dpf =
      TextEditingController(); // Diabetes Pedigree Function
  final TextEditingController age = TextEditingController();

  String? _result;

  Future<void> predictDiabetes() async {
    if (!_formKey.currentState!.validate()) return;

    final url = Uri.parse(
        "https://your-api-url.onrender.com/predict"); // Replace with your deployed FastAPI endpoint

    final body = {
      "Pregnancies": int.parse(pregnancies.text),
      "Glucose": double.parse(glucose.text),
      "BloodPressure": double.parse(bloodPressure.text),
      "SkinThickness": double.parse(skinThickness.text),
      "Insulin": double.parse(insulin.text),
      "BMI": double.parse(bmi.text),
      "DiabetesPedigreeFunction": double.parse(dpf.text),
      "Age": int.parse(age.text),
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        setState(() {
          _result =
              decoded['prediction'] == 1 ? 'Likely Diabetic' : 'Not Diabetic';
        });
      } else {
        setState(() => _result = "Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _result = "Failed to connect to API.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Diabetes Prediction")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField("Pregnancies", pregnancies, TextInputType.number),
              _buildField("Glucose", glucose, TextInputType.number),
              _buildField(
                  "Blood Pressure", bloodPressure, TextInputType.number),
              _buildField(
                  "Skin Thickness", skinThickness, TextInputType.number),
              _buildField("Insulin", insulin, TextInputType.number),
              _buildField("BMI", bmi, TextInputType.number),
              _buildField(
                  "Diabetes Pedigree Function", dpf, TextInputType.number),
              _buildField("Age", age, TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: predictDiabetes,
                child: const Text("Predict"),
              ),
              const SizedBox(height: 20),
              if (_result != null)
                Text(
                  _result!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Enter $label';
          return null;
        },
      ),
    );
  }
}
