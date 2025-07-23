import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const PredictionScreen({super.key, required this.onToggleTheme});

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

  int? tryParseInt(String val) => int.tryParse(val);
  double? tryParseDouble(String val) => double.tryParse(val);

  Future<void> predictDiabetes() async {
    if (!_formKey.currentState!.validate()) return;

    final values = [
      tryParseInt(pregnancies.text),
      tryParseInt(glucose.text),
      tryParseInt(bloodPressure.text),
      tryParseInt(skinThickness.text),
      tryParseInt(insulin.text),
      tryParseDouble(bmi.text),
      tryParseDouble(dpf.text),
      tryParseInt(age.text),
    ];

    if (values.contains(null)) {
      setState(() => _result = "Please enter valid numbers in all fields.");
      return;
    }

    final url =
        Uri.parse("https://linear-regression-model-trk1.onrender.com/predict");

    final body = {
      "Pregnancies": values[0],
      "Glucose": values[1],
      "BloodPressure": values[2],
      "SkinThickness": values[3],
      "Insulin": values[4],
      "BMI": values[5],
      "DiabetesPedigreeFunction": values[6],
      "Age": values[7],
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
        setState(() => _result = "Error: ${response.statusCode}");
      }
    } catch (_) {
      setState(() => _result = "Failed to connect to API.");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    for (var controller in [
      pregnancies,
      glucose,
      bloodPressure,
      skinThickness,
      insulin,
      bmi,
      dpf,
      age,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("Diabetes Prediction")),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onToggleTheme,
        child: const Icon(Icons.brightness_6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your health metrics:",
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildField("Pregnancies", pregnancies),
              _buildField("Glucose", glucose),
              _buildField("Blood Pressure", bloodPressure),
              _buildField("Skin Thickness", skinThickness),
              _buildField("Insulin", insulin),
              _buildField("BMI", bmi),
              _buildField("Diabetes Pedigree Function", dpf),
              _buildField("Age", age),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : predictDiabetes,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Predict"),
                ),
              ),
              const SizedBox(height: 24),
              if (_result != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: isDark ? Colors.white : Colors.blue),
                  ),
                  child: Text(
                    _result!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          _result!.contains("Not") ? Colors.green : Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.health_and_safety),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Enter $label';
          return null;
        },
      ),
    );
  }
}
