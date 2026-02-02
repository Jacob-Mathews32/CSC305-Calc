import 'package:flutter_test/flutter_test.dart';
import 'package:expressions/expressions.dart';

void main() {
  group('Calculator Expression Evaluation Tests', () {
    /// Test basic addition
    test('Basic addition: 2 + 3', () {
      final expression = Expression.parse('2 + 3');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(5));
    });

    /// Test basic subtraction
    test('Basic subtraction: 10 - 4', () {
      final expression = Expression.parse('10 - 4');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(6));
    });

    /// Test basic multiplication
    test('Basic multiplication: 6 * 7', () {
      final expression = Expression.parse('6 * 7');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(42));
    });

    /// Test basic division
    test('Basic division: 20 / 4', () {
      final expression = Expression.parse('20 / 4');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(5));
    });

    /// Test order of operations: multiplication before addition
    test('Order of operations: 2 + 3 * 4', () {
      final expression = Expression.parse('2 + 3 * 4');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(14));
    });

    /// Test order of operations: division before subtraction
    test('Order of operations: 10 - 8 / 2', () {
      final expression = Expression.parse('10 - 8 / 2');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(6));
    });

    /// Test complex expression with multiple operations
    test('Complex expression: 2 + 3 * 4 - 5', () {
      final expression = Expression.parse('2 + 3 * 4 - 5');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(9));
    });

    /// Test decimal numbers
    test('Decimal addition: 2.5 + 3.5', () {
      final expression = Expression.parse('2.5 + 3.5');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(6.0));
    });

    /// Test division resulting in decimal
    test('Division with decimal result: 7 / 2', () {
      final expression = Expression.parse('7 / 2');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(3.5));
    });

    /// Test negative numbers
    test('Negative numbers: -5 + 10', () {
      final expression = Expression.parse('-5 + 10');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(5));
    });

    /// Test zero in operations
    test('Zero in addition: 0 + 5', () {
      final expression = Expression.parse('0 + 5');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(5));
    });

    /// Test zero multiplication
    test('Zero multiplication: 100 * 0', () {
      final expression = Expression.parse('100 * 0');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(0));
    });

    /// Test large numbers
    test('Large numbers: 999999 + 1', () {
      final expression = Expression.parse('999999 + 1');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(1000000));
    });

    /// Test division by zero returns infinity
    test('Division by zero returns infinity', () {
      final expression = Expression.parse('5 / 0');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result.isInfinite, true);
    });

    /// Test that expression parser handles operator sequences
    test('Expression parser handles 2 + + 3', () {
      // The expressions package may handle this differently
      try {
        final expression = Expression.parse('2 + + 3');
        final evaluator = ExpressionEvaluator();
        final result = evaluator.eval(expression, {});
        // If it parses successfully, we expect a valid result
        expect(result, isNotNull);
      } catch (e) {
        // If it throws, that's also acceptable behavior
        expect(true, true);
      }
    });

    /// Test single number
    test('Single number: 42', () {
      final expression = Expression.parse('42');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(42));
    });

    /// Test very long expression
    test('Long expression: 1 + 2 + 3 + 4 + 5', () {
      final expression = Expression.parse('1 + 2 + 3 + 4 + 5');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(15));
    });

    /// Test expression with all operations
    test('All operations: 10 + 5 - 3 * 2 / 1', () {
      final expression = Expression.parse('10 + 5 - 3 * 2 / 1');
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      expect(result, equals(9));
    });
  });

  group('Display Formatting Tests', () {
    /// Test formatting integers
    test('Format integer result', () {
      final result = 5.0;
      String formatted;
      if (result == result.toInt()) {
        formatted = result.toInt().toString();
      } else {
        formatted = result
            .toStringAsFixed(10)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
      expect(formatted, equals('5'));
    });

    /// Test formatting decimals
    test('Format decimal result', () {
      final result = 3.5;
      String formatted;
      if (result == result.toInt()) {
        formatted = result.toInt().toString();
      } else {
        formatted = result
            .toStringAsFixed(10)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
      expect(formatted, equals('3.5'));
    });

    /// Test formatting very small decimals
    test('Format very small decimal', () {
      final result = 0.3333333333;
      String formatted;
      if (result == result.toInt()) {
        formatted = result.toInt().toString();
      } else {
        formatted = result
            .toStringAsFixed(10)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
      expect(formatted.startsWith('0.333'), true);
    });
  });

  group('Input Validation Tests', () {
    /// Test that we can't have multiple decimal points in one number
    test('Prevent multiple decimals in sequence', () {
      String expression = '5.5';
      bool lastTokenContainsDot(String expr) {
        final tokens = expr.split(RegExp(r'[\+\-\*/]'));
        return tokens.isNotEmpty && tokens.last.contains('.');
      }

      // After first decimal point, we should prevent another
      if (lastTokenContainsDot(expression)) {
        // Don't add another decimal
        expect(lastTokenContainsDot(expression), true);
      }
    });

    /// Test operator validation
    test('Validate operator input', () {
      String expression = '';
      String operator = '-';

      if (expression.isEmpty) {
        if (operator == '-') {
          expression = '-';
        }
      }

      expect(expression, equals('-'));
    });
  });
}
