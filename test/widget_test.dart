import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workspace/main.dart';

void main() {
  group('Calculator Widget Tests', () {
    /// Test that the calculator app can be instantiated
    test('CalculatorApp can be created', () {
      const app = CalculatorApp();
      expect(app, isNotNull);
    });

    /// Test that the calculator screen can be created
    test('CalculatorScreen can be created', () {
      const screen = CalculatorScreen();
      expect(screen, isNotNull);
    });

    /// Test that the calculator state initializes properly
    test('CalculatorScreen creates state', () {
      const screen = CalculatorScreen();
      final state = screen.createState();
      expect(state, isNotNull);
    });

    /// Test MaterialApp configuration
    testWidgets('Calculator app configures MaterialApp correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Verify the MaterialApp is created
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// Test AppBar existence and title
    testWidgets('AppBar has correct title', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Check that AppBar exists
      expect(find.byType(AppBar), findsOneWidget);

      // Check for the title text
      expect(find.text('Calculator - Developed by GitHub Copilot'),
          findsOneWidget);
    });

    /// Test that Scaffold is present
    testWidgets('Scaffold is present in the app', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      expect(find.byType(Scaffold), findsOneWidget);
    });

    /// Test that buttons are present
    testWidgets('Button widgets are present', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Check for ElevatedButton widgets
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    /// Test that display container is present
    testWidgets('Display container is present', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Check for Container widgets used for display
      expect(find.byType(Container), findsWidgets);
    });

    /// Test Column and Row layouts
    testWidgets('Layout uses Column and Row widgets', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Check for layout widgets
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Row), findsWidgets);
    });

    /// Test that Text widgets are present for display
    testWidgets('Text widgets are present for display',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Check for Text widgets
      expect(find.byType(Text), findsWidgets);
    });
  });
}
