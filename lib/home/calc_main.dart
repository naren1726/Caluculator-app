import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == "-") {
        equationFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38;
        resultFontSize = 48;
        expression = equation;

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 38;
        resultFontSize = 48;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
          ),
        ),
      ),
      padding: EdgeInsets.all(16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4F5D6C),
        elevation: 20,
        centerTitle: true,
        title: new Text("Simple Calculator"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Color(0xff282828)),
                      buildButton("", 1, Color(0xff282828)),
                      buildButton("/", 1, Color(0xff282828)),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Color(0xff282828)),
                      buildButton("8", 1, Color(0xff282828)),
                      buildButton("9", 1, Color(0xff282828)),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Color(0xff282828)),
                      buildButton("5", 1, Color(0xff282828)),
                      buildButton("6", 1, Color(0xff282828)),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Color(0xff282828)),
                      buildButton("2", 1, Color(0xff282828)),
                      buildButton("3", 1, Color(0xff282828)),
                    ]),
                    TableRow(children: [
                      buildButton("0", 1, Color(0xff282828)),
                      buildButton(".", 1, Color(0xff282828)),
                      buildButton("00", 1, Color(0xff282828)),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("+", 1, Color(0xff282828)),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Color(0xff282828)),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("*", 1, Color(0xff282828)),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Color(0xffF54D02)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
