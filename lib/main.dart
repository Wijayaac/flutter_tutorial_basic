import 'dart:async';

import 'package:flutter/material.dart';

extension StringExtension on String {
  bool get isNumber => isNotEmpty && contains(RegExp(r'[0-9]'));
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final StreamController<String> inputDisplayController = StreamController();
  final StreamController<String> resultDisplayController = StreamController();

  final List<String> tempInputs = [];

  void clearAllInputs() {
    if (tempInputs.isNotEmpty) {
      tempInputs.clear();
      inputDisplayController.sink.add(tempInputs.join());
      resultDisplayController.sink.add("0");
    }
  }

  void deleteInput() {
    if (tempInputs.isNotEmpty) {
      tempInputs.removeLast();
      if (tempInputs.isEmpty) {
        inputDisplayController.sink.add("0");
      } else {
        inputDisplayController.sink.add(tempInputs.join());
      }
    }
  }

  num calculate(String operator, num firstNumber, num secondNumber) {
    switch (operator) {
      case "+":
        return firstNumber + secondNumber;
      case "-":
        return firstNumber - secondNumber;
      case "÷":
        try {
          return firstNumber / secondNumber;
        } catch (e) {
          return 0;
        }
      case "×":
        return firstNumber * secondNumber;
      default:
        return 0;
    }
  }

  void calculateInputs() {
    if (tempInputs.isNotEmpty) {
      final tempNumbers = tempInputs.join().split(RegExp(r'[+-]|[÷×]'));
      final tempOperators = tempInputs.join().split(RegExp(r'[0-9]|[.]'));
      tempOperators.removeWhere((element) => element.isEmpty);

      final mainNumbers = tempNumbers.map((e) => e.contains('.') ? double.parse(e) : int.parse(e)).toList();
      final mainOpers = List<String>.from(tempOperators);

      num result = 0;
      int countCalc = 0;
      if (mainOpers.isNotEmpty) {
        do {
          final operator = mainOpers.removeAt(0);

          if (countCalc == 0) {
            final firstNumber = mainNumbers.removeAt(0);
            final secondNumber = mainNumbers.removeAt(0);

            result = calculate(operator, firstNumber, secondNumber);
            countCalc++;
          } else {
            final number = mainNumbers.removeAt(0);
            result = calculate(operator, result, number);
            countCalc++;
          }
        } while (mainOpers.isNotEmpty);

        resultDisplayController.sink.add(result.toString());
      }

      print(tempNumbers);
      print(tempOperators);

      // inputDisplayController.sink.add(tempInputs.join());
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<List<String>> listLayoutNumbers = [
      ['AC', 'Del', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '+'],
      ['1', '2', '3', '-'],
      ['0', '.', '='],
    ];

    final Map charColors = {
      'AC': Colors.grey.shade200,
      'Del': Colors.grey.shade200,
      '0': Colors.grey.shade200,
      '.': Colors.grey.shade200,
      '÷': Colors.orange,
      '×': Colors.orange,
      '+': Colors.orange,
      '-': Colors.orange,
      '=': Colors.orange,
    };

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(vertical: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  StreamBuilder<String>(
                      stream: inputDisplayController.stream,
                      builder: (context, snapshot) {
                        final input = snapshot.data ?? '0';
                        return Text(
                          input,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                        );
                      }),
                  SizedBox(
                    height: 8,
                  ),
                  StreamBuilder<String>(
                      stream: resultDisplayController.stream,
                      builder: (context, snapshot) {
                        final resultScreen = snapshot.data ?? '';
                        return Text(
                          resultScreen,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey),
                        );
                      }),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  for (final list in listLayoutNumbers)
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          for (final char in list)
                            Expanded(
                              flex: ['AC', '0'].contains(char) ? 2 : 1,
                              child: Material(
                                color: charColors.containsKey(char) ? charColors[char] : Colors.grey.shade100,
                                child: InkWell(
                                  onTap: () {
                                    if (char.isNumber) {
                                      tempInputs.add(char);
                                      inputDisplayController.sink.add(tempInputs.join());
                                    } else if (char == '.') {
                                      int indexStartSub = tempInputs.lastIndexWhere((e) => ['÷', '×', '-', '+'].contains(e));
                                      int indexEndSub = tempInputs.length - 1;

                                      List<String> subTempInputs = List<String>.from(tempInputs);
                                      if (indexStartSub != -1) {
                                        subTempInputs = tempInputs.sublist(indexStartSub + 1, indexEndSub + 1);
                                      }

                                      if (!subTempInputs.contains('.')) {
                                        if (subTempInputs.isNotEmpty && subTempInputs.last.isNumber) {
                                          tempInputs.add(char);
                                        }
                                      }

                                      inputDisplayController.sink.add(tempInputs.join());
                                    } else if (['÷', '×', '-', '+'].contains(char)) {
                                      if (tempInputs.isNotEmpty) {
                                        if (tempInputs.last.isNumber) {
                                          tempInputs.add(char);
                                        } else {
                                          tempInputs.removeLast();
                                          tempInputs.add(char);
                                        }
                                      }
                                      inputDisplayController.sink.add(tempInputs.join());
                                    } else if (char == 'AC') {
                                      clearAllInputs();
                                    } else if (char == 'Del') {
                                      deleteInput();
                                    } else if (char == '=') {
                                      calculateInputs();
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      char,
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
