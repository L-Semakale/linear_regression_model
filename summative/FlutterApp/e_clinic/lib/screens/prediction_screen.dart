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

  final TextEditingController pregnancies = TextEditingController();
  final TextEditingController glucose = TextEditingController();
  final TextEditingController bloodPressure = TextEditingController();
  final TextEditingController skinThickness = TextEditingController();
  final TextEditingController insulin = TextEditingController();
  final TextEditingController bmi = TextEditingController();
  final TextEditingController dpf = TextEditingController();
  final TextEditingController age = TextEditingController();

  String? _result;
  bool _loading = false;

  int? tryParseInt(String val) {
    try {
      return int.parse(val);
    } catch (_) {
      return null;
    }
  }

  double? tryParseDouble(String val) {
    try {
      return double.parse(val);
    } catch (_) {
      return null;
    }
  }

  Future<void> predictDiabetes() async {
    if (!_formKey.currentState!.validate()) return;

    final int? pregVal = tryParseInt(pregnancies.text);
    final int? gluVal = tryParseInt(glucose.text);
    final int? bpVal = tryParseInt(bloodPressure.text);
    final int? skinVal = tryParseInt(skinThickness.text);
    final int? insulinVal = tryParseInt(insulin.text);
    final double? bmiVal = tryParseDouble(bmi.text);
    final double? dpfVal = tryParseDouble(dpf.text);
    final int? ageVal = tryParseInt(age.text);

    if ([pregVal, gluVal, bpVal, skinVal, insulinVal, bmiVal, dpfVal, ageVal]
        .contains(null)) {
      setState(() => _result = "Please enter valid numbers in all fields.");
      return;
    }

    final url =
        Uri.parse("https://linear-regression-model-trk1.onrender.com/predict");

    final body = {
      "Pregnancies": pregVal!,
      "Glucose": gluVal!,
      "BloodPressure": bpVal!,
      "SkinThickness": skinVal!,
      "Insulin": insulinVal!,
      "BMI": bmiVal!,
      "DiabetesPedigreeFunction": dpfVal!,
      "Age": ageVal!,
    };

    setState(() {
      _loading = true;
      _result = null;
    });

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
        setState(() => _result =
            "Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      setState(() => _result = "Failed to connect to API.");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    pregnancies.dispose();
    glucose.dispose();
    bloodPressure.dispose();
    skinThickness.dispose();
    insulin.dispose();
    bmi.dispose();
    dpf.dispose();
    age.dispose();
    super.dispose();
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
                onPressed: _loading ? null : predictDiabetes,
                child: _loading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Predict"),
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
