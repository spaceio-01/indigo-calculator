import 'package:flutter/material.dart';
import 'dart:math' as math;

class CalculatorScreen extends StatefulWidget {
  @override
  State<CalculatorScreen> createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController firstControler = TextEditingController();
  final TextEditingController secondControler = TextEditingController();

  String result = "0";

  double get firstValue => double.tryParse(firstControler.text) ?? 0;
  double get secondValue => double.tryParse(secondControler.text) ?? 0;

  String formatResult(double val) {
    if (val % 1 == 0) {
      return val.toInt().toString();
    }
    return val.toString();
  }

  void resetCalculator() {
    setState(() {
      firstControler.clear();
      secondControler.clear();
      result = "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: firstControler,
              keyboardType: TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Enter first number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: secondControler,
              keyboardType: TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Enter second number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      result = formatResult(firstValue + secondValue);
                    });
                  },
                  child: Text('+', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      result = formatResult(firstValue - secondValue);
                    });
                  },
                  child: Text('-', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      result = formatResult(firstValue * secondValue);
                    });
                  },
                  child: Text('×', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (secondValue == 0) {
                        result = "Error: Can't divide by 0";
                      } else {
                        result = formatResult(firstValue / secondValue);
                      }
                    });
                  },
                  child: Text('÷', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
            SizedBox(height: 16), 

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (firstValue < 0) {
                        result = "Error: Invalid input";
                      } else {
                        result = formatResult(math.sqrt(firstValue));
                      }
                    });
                  },
                  child: Text('√', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      result = formatResult((firstValue * secondValue) / 100);
                    });
                  },
                  child: Text('%', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                  ),
                  onPressed: resetCalculator,
                  child: Text(
                    'AC',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                result.startsWith("Error") ? result : "Answer: $result",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: result.startsWith("Error") ? 20 : 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
