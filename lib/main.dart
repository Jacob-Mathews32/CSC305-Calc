import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _expression = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _updateDisplay();
  }

  void _updateDisplay() {
    setState(() {
      if (_expression.isEmpty) {
        _display = '0';
      } else {
        _display = _expression;
      }
    });
  }

  void _appendNumber(String number) {
    setState(() {
      _errorMessage = '';
      if (_expression == '0' && number != '.') {
        _expression = number;
      } else if (number == '.' && _expression.isEmpty) {
        _expression = '0.';
      } else if (number == '.' && _endsWithOperator()) {
        _expression += '0.';
      } else if (number != '.' || !_lastTokenContainsDot()) {
        _expression += number;
      }
      _updateDisplay();
    });
  }

  bool _endsWithOperator() {
    if (_expression.isEmpty) return false;
    final lastChar = _expression[_expression.length - 1];
    return lastChar == '+' ||
        lastChar == '-' ||
        lastChar == '*' ||
        lastChar == '/';
  }

  bool _lastTokenContainsDot() {
    final tokens = _expression.split(RegExp(r'[\+\-\*/]'));
    return tokens.isNotEmpty && tokens.last.contains('.');
  }

  void _appendOperator(String operator) {
    setState(() {
      _errorMessage = '';
      if (_expression.isEmpty) {
        if (operator == '-') {
          _expression = '-';
        }
      } else if (_endsWithOperator()) {
        if (operator == '-' && !_expression.endsWith('-')) {
          _expression += operator;
        } else {
          _expression = _expression.replaceAll(RegExp(r'[\+\-\*/]$'), operator);
        }
      } else {
        _expression += ' $operator ';
      }
      _updateDisplay();
    });
  }

  void _calculate() {
    try {
      setState(() {
        _errorMessage = '';
        if (_expression.isEmpty) {
          return;
        }

        final expression = Expression.parse(_expression);
        final evaluator = ExpressionEvaluator();
        final result = evaluator.eval(expression, {});

        // Check for infinity (division by zero)
        if (result is double && result.isInfinite) {
          _errorMessage = 'Error: Cannot divide by zero';
          _display = 'Error';
          return;
        }

        // Check for NaN
        if (result is double && result.isNaN) {
          _errorMessage = 'Error: Invalid calculation';
          _display = 'Error';
          return;
        }

        // Format result to remove unnecessary decimals
        String formattedResult;
        if (result is double) {
          if (result == result.toInt()) {
            formattedResult = result.toInt().toString();
          } else {
            formattedResult = result
                .toStringAsFixed(10)
                .replaceAll(RegExp(r'0+$'), '')
                .replaceAll(RegExp(r'\.$'), '');
          }
        } else {
          formattedResult = result.toString();
        }

        _expression = '$_expression = $formattedResult';
        _updateDisplay();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: Invalid expression';
        _display = 'Error';
      });
    }
  }

  void _clear() {
    setState(() {
      _expression = '';
      _display = '0';
      _errorMessage = '';
    });
  }

  void _delete() {
    setState(() {
      if (_expression.isNotEmpty) {
        _expression = _expression.substring(0, _expression.length - 1);
        if (_expression.isEmpty) {
          _display = '0';
        } else {
          _updateDisplay();
        }
      }
    });
  }

  void _square() {
    try {
      setState(() {
        _errorMessage = '';
        if (_expression.isEmpty) {
          return;
        }

        final expression = Expression.parse(_expression);
        final evaluator = ExpressionEvaluator();
        final result = evaluator.eval(expression, {});

        // Check for infinity or NaN
        if (result is double && (result.isInfinite || result.isNaN)) {
          _errorMessage = 'Error: Invalid calculation';
          _display = 'Error';
          return;
        }

        // Square the result
        final squared = result * result;

        // Format result
        String formattedResult;
        if (squared is double) {
          if (squared == squared.toInt()) {
            formattedResult = squared.toInt().toString();
          } else {
            formattedResult = squared
                .toStringAsFixed(10)
                .replaceAll(RegExp(r'0+$'), '')
                .replaceAll(RegExp(r'\.$'), '');
          }
        } else {
          formattedResult = squared.toString();
        }

        _expression = '($_expression)² = $formattedResult';
        _updateDisplay();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: Invalid expression';
        _display = 'Error';
      });
    }
  }

  Widget _buildButton(
    String label,
    VoidCallback onPressed, {
    Color? backgroundColor,
    Color? textColor,
    double fontSize = 24,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.grey[300],
            foregroundColor: textColor ?? Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final displayFontSize = isMobile ? 32.0 : 48.0;
    final buttonFontSize = isMobile ? 20.0 : 24.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator - Developed by GitHub Copilot'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Display Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Expression/Result Display
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      _display,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: displayFontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier',
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Error Message Display
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                ],
              ),
            ),

            // Buttons Section
            Expanded(
              child: Column(
                children: [
                  // Row 1: C, DEL, x², /
                  Row(
                    children: [
                      _buildButton(
                        'C',
                        _clear,
                        backgroundColor: Colors.red[400],
                        textColor: Colors.white,
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        'DEL',
                        _delete,
                        backgroundColor: Colors.orange[400],
                        textColor: Colors.white,
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        'x²',
                        _square,
                        backgroundColor: Colors.purple[400],
                        textColor: Colors.white,
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '/',
                        () => _appendOperator('/'),
                        backgroundColor: Colors.blue[400],
                        textColor: Colors.white,
                        fontSize: buttonFontSize,
                      ),
                    ],
                  ),
                  // Row 2: 7, 8, 9, *
                  Row(
                    children: [
                      _buildButton(
                        '7',
                        () => _appendNumber('7'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '8',
                        () => _appendNumber('8'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '9',
                        () => _appendNumber('9'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '*',
                        () => _appendOperator('*'),
                        backgroundColor: Colors.blue[400],
                        textColor: Colors.white,
                        fontSize: buttonFontSize,
                      ),
                    ],
                  ),
                  // Row 3: 4, 5, 6, -
                  Row(
                    children: [
                      _buildButton(
                        '4',
                        () => _appendNumber('4'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '5',
                        () => _appendNumber('5'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '6',
                        () => _appendNumber('6'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '-',
                        () => _appendOperator('-'),
                        backgroundColor: Colors.blue[400],
                        textColor: Colors.white,
                        fontSize: buttonFontSize,
                      ),
                    ],
                  ),
                  // Row 4: 1, 2, 3, +
                  Row(
                    children: [
                      _buildButton(
                        '1',
                        () => _appendNumber('1'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '2',
                        () => _appendNumber('2'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '3',
                        () => _appendNumber('3'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '+',
                        () => _appendOperator('+'),
                        backgroundColor: Colors.blue[400],
                        textColor: Colors.white,
                        fontSize: buttonFontSize,
                      ),
                    ],
                  ),
                  // Row 5: 0, ., =
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: ElevatedButton(
                            onPressed: () => _appendNumber('0'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              '0',
                              style: TextStyle(
                                fontSize: buttonFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      _buildButton(
                        '.',
                        () => _appendNumber('.'),
                        fontSize: buttonFontSize,
                      ),
                      _buildButton(
                        '=',
                        _calculate,
                        backgroundColor: Colors.green[400],
                        textColor: Colors.white,
                        fontSize: buttonFontSize,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
