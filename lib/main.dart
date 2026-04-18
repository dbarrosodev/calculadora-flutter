import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String visor = "0";
  String firstNumber = "";
  String operation = "";
  String secondNumber = "";
  bool resetVisor = false;

  void updateVisor(String buttonText) {
    setState(() {
      // 1. Categoria: LIMPEZA (AC e CE)
      if (buttonText == "AC") {
        visor = "0";
        firstNumber = "";
        operation = "";
        secondNumber = "";
        resetVisor = false;
        return; // Sai da função para não processar mais nada
      }

      if (buttonText == "CE") {
        visor = "0";
        return;
      }

      // 2. Categoria: OPERADORES (+, -, ×, ÷, √)
      if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        firstNumber = visor;
        operation = buttonText;
        resetVisor = true; // Avisa que o próximo número deve limpar o visor
        visor = buttonText;
        return;
      }

      if (buttonText == "√") {
        double num = double.parse(visor);
        visor = sqrt(num).toStringAsFixed(2);
        resetVisor = true;
        return;
      }

      // 3. Categoria: IGUAL (=)
      if (buttonText == "=") {
        if (operation.isEmpty || firstNumber.isEmpty) return;

        secondNumber = visor;
        double num1 = double.parse(firstNumber);
        double num2 = double.parse(secondNumber);

        if (operation == "+") visor = (num1 + num2).toString();
        if (operation == "-") visor = (num1 - num2).toString();
        if (operation == "×") visor = (num1 * num2).toString();
        if (operation == "÷") visor = (num1 / num2).toStringAsFixed(2);
        operation = ""; // Reseta para a próxima conta
        resetVisor = true;
        return;
      }

      // 4. Categoria: NÚMEROS E PONTO
      if (resetVisor || visor == "0") {
        visor = buttonText;
        resetVisor = false;
      } else {
        visor += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Screen(value: visor),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: ButtonRow(labels: const ["CE", "AC"], onClick: updateVisor, buttonColor: Colors.deepOrange.shade300)),
                      const SizedBox(height: 8),
                      Expanded(child: ButtonRow(labels: const ["M+", "M-", "MRC", "GT", "->"], onClick: updateVisor, buttonColor: Colors.lightGreen.shade300)),
                      const SizedBox(height: 8),
                      Expanded(child: ButtonRow(labels: const ["7", "8", "9", "÷", "√"], onClick: updateVisor, buttonColor: Colors.yellow.shade200)),
                      const SizedBox(height: 8),
                      Expanded(child: ButtonRow(labels: const ["4", "5", "6", "×", "%"], onClick: updateVisor, buttonColor: Colors.pink.shade100)),
                      const SizedBox(height: 8),
                      Expanded(child: ButtonRow(labels: const ["1", "2", "3", "-", "MU"], onClick: updateVisor, buttonColor: Colors.purple.shade200)),
                      const SizedBox(height: 8),
                      Expanded(child: ButtonRow(labels: const ["0", "00", ".", "+", "="], onClick: updateVisor, buttonColor: Colors.cyan.shade200)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Screen extends StatelessWidget {
  final String value;

  const Screen({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFC7D095),
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        alignment: Alignment.centerRight,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            value,
            style: GoogleFonts.shareTechMono(
              fontSize: 50,
              fontWeight: FontWeight.w300,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  final List<String> labels;
  final Function(String) onClick;
  final Color buttonColor;

  const ButtonRow({super.key, required this.labels, required this.onClick, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: labels
          .map(
            (label) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ElevatedButton(
                    onPressed: () => onClick(label),
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shadowColor: Colors.black,
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.black,
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.varelaRound(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
