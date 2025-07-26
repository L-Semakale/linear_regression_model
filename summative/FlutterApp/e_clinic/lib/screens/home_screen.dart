import 'package:flutter/material.dart';
import 'package:e_clinic/screens/prediction_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const HomeScreen({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black87, Colors.teal.shade900]
                : [Colors.blue.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Icon(
                  Icons.favorite_rounded,
                  size: 64,
                  color: isDark ? Colors.tealAccent : Colors.blueAccent,
                ),
                const SizedBox(height: 20),
                Text(
                  "Diabetes Predictor",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "Empowering you with early prediction insights.\nLet's take care of your health together.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  icon: const Icon(Icons.analytics),
                  label: const Text("Start Prediction"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.teal : Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    shadowColor: Colors.black38,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PredictionScreen(onToggleTheme: onToggleTheme),
                      ),
                    );
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.brightness_6_rounded,
                    size: 30,
                    color: isDark ? Colors.amber : Colors.black54,
                  ),
                  tooltip: "Toggle Theme",
                  onPressed: onToggleTheme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
