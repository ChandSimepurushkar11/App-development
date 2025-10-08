import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  double? firstNum;
  String? operator;
  bool shouldResetDisplay = false;

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
        firstNum = null;
        operator = null;
        shouldResetDisplay = false;
        return;
      }

      if (value == '⌫') {
        if (shouldResetDisplay) {
          display = '0';
          shouldResetDisplay = false;
        } else {
          if (display.length > 1) {
            display = display.substring(0, display.length - 1);
          } else {
            display = '0';
          }
        }
        return;
      }

      if ('+-×÷'.contains(value)) {
        // store current number and operator
        firstNum = double.tryParse(display) ?? 0.0;
        operator = value;
        shouldResetDisplay = true;
        return;
      }

      if (value == '=') {
        if (operator == null || firstNum == null) return;
        double second = double.tryParse(display) ?? 0.0;
        double? result = compute(firstNum!, second, operator!);
        display = formatResult(result);
        // reset for next operation
        operator = null;
        firstNum = null;
        shouldResetDisplay = true;
        return;
      }

      // number or dot input
      if (value == '.') {
        if (shouldResetDisplay) {
          display = '0.';
          shouldResetDisplay = false;
        } else if (!display.contains('.')) {
          display += '.';
        }
        return;
      }

      // digit (0-9)
      if (RegExp(r'^\d$').hasMatch(value)) {
        if (display == '0' || shouldResetDisplay) {
          display = value;
          shouldResetDisplay = false;
        } else {
          display += value;
        }
      }
    });
  }

  double? compute(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        if (b == 0) return double.nan;
        return a / b;
    }
    return null;
  }

  String formatResult(double? r) {
    if (r == null) return 'Error';
    if (r.isNaN || r.isInfinite) return 'Error';
    // If whole number, show without decimal
    if (r == r.roundToDouble()) return r.toInt().toString();
    // otherwise show up to 10 significant digits and trim trailing zeros
    String s = r.toStringAsPrecision(10);
    return s.replaceFirst(RegExp(r'\.?0+$'), '');
  }

  Widget buildButton(String label, {double height = 1}) {
    return Expanded(
      flex: height == 1 ? 1 : (height * 10).toInt(),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => onButtonPressed(label),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            // default color palette — change if you want
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Buttons layout
    final rows = [
      ['C', '⌫', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '0', '.', '='], // '0' doubled to make it wider visually
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black12,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 28),
              alignment: Alignment.bottomRight,
              child: Text(
                display,
                style: TextStyle(fontSize: 52, fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Buttons
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(children: [
                    buildButton('C'),
                    buildButton('⌫'),
                    buildButton('%'),
                    buildButton('÷'),
                  ]),
                  Row(children: [
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('×'),
                  ]),
                  Row(children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('-'),
                  ]),
                  Row(children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('+'),
                  ]),
                  Row(children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton(
                          onPressed: () => onButtonPressed('0'),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 28.0),
                              child: Text('0', style: TextStyle(fontSize: 24)),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 18)),
                        ),
                      ),
                    ),
                    buildButton('.'),
                    buildButton('='),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
