import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e_clinic/main.dart';

void main() {
  testWidgets('Navigate to prediction page and verify UI', (WidgetTester tester) async {
    await tester.pumpWidget(const SymptomsCheckerApp());

    // Home Page
    expect(find.text('Symptoms AI Checker'), findsOneWidget);
    expect(find.byKey(const Key('startButton')), findsOneWidget);

    // Tap start
    await tester.tap(find.byKey(const Key('startButton')));
    await tester.pumpAndSettle();

    // Prediction Page
    expect(find.text('Enter Symptoms'), findsOneWidget);
    expect(find.byKey(const Key('coughField')), findsOneWidget);
    expect(find.byKey(const Key('feverField')), findsOneWidget);
    expect(find.byKey(const Key('soreThroatField')), findsOneWidget);
    expect(find.byKey(const Key('predictButton')), findsOneWidget);
  });
}
