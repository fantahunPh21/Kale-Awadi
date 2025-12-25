// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qale_awadi_constitution/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ConstitutionApp());

    // Verify that the app loads (splash screen or main content)
    // The app will show a splash screen initially, so we wait for it
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify that the app has loaded (check for any text that should be present)
    // This is a basic smoke test to ensure the app doesn't crash
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
