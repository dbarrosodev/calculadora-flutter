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
  String calculatorMemory = "0";
  bool resetVisor = false;

  String _formatResult(double value) {
    if (value.isInfinite || value.isNaN) return "Erro";
    
    // Se for um número inteiro, remove o .0
    if (value == value.toInt()) {
      return value.toInt().toString();
    }

    String res = value.toString();
    
    // Se o número for muito longo, tentamos limitar as casas decimais primeiro
    if (res.length > 12) {
      // Se for um número pequeno ou grande demais, usa notação científica
      if (value.abs() > 1e10 || (value.abs() < 1e-5 && value != 0)) {
        return value.toStringAsExponential(5);
      } else {
        // Caso contrário, apenas limita os decimais
        return value.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
    }
    return res;
  }

  void _calculate() {
    if (operation.isEmpty || firstNumber.isEmpty) return;

    double num1 = double.tryParse(firstNumber) ?? 0.0;
    double num2 = double.tryParse(visor) ?? 0.0;
    double result = 0.0;

    switch (operation) {
      case "+":
        result = num1 + num2;
        break;
      case "-":
        result = num1 - num2;
        break;
      case "×":
        result = num1 * num2;
        break;
      case "÷":
        if (num2 == 0) {
          visor = "Erro";
          operation = "";
          firstNumber = "";
          resetVisor = true;
          return;
        }
        result = num1 / num2;
        break;
    }

    visor = _formatResult(result);
    firstNumber = visor;
    operation = "";
    resetVisor = true;
  }

  void updateVisor(String buttonText) {
    setState(() {
      // 1. Categoria: LIMPEZA (AC e CE)
      if (buttonText == "AC") {
        visor = "0";
        firstNumber = "";
        operation = "";
        calculatorMemory = "0";
        resetVisor = false;
        return;
      }

      if (buttonText == "CE") {
        visor = "0";
        return;
      }

      // 2. Categoria: MEMÓRIA
      if (buttonText == "M+" || buttonText == "M-") {
        double mem = double.tryParse(calculatorMemory) ?? 0.0;
        double val = double.tryParse(visor) ?? 0.0;
        if (buttonText == "M+") {
          calculatorMemory = (mem + val).toString();
        } else {
          calculatorMemory = (mem - val).toString();
        }
        resetVisor = true;
        return;
      }

      if (buttonText == "MRC") {
        visor = _formatResult(double.tryParse(calculatorMemory) ?? 0.0);
        resetVisor = true;
        return;
      }

      // 3. Categoria: BOTÕES ESPECIAIS
      if (buttonText == "->") {
        if (resetVisor || visor == "Erro") {
          visor = "0";
          resetVisor = false;
        } else if (visor.length > 1) {
          visor = visor.substring(0, visor.length - 1);
        } else {
          visor = "0";
        }
        return;
      }

      if (buttonText == "%") {
        double val = double.tryParse(visor) ?? 0.0;
        if (operation.isNotEmpty && firstNumber.isNotEmpty) {
          // Lógica contextual: 100 + 10% = 110
          double base = double.tryParse(firstNumber) ?? 0.0;
          double percentValue = (base * val) / 100;
          visor = _formatResult(percentValue);
        } else {
          // Lógica simples: 50% = 0.5
          visor = _formatResult(val / 100);
        }
        // resetVisor = true; // Não resetamos aqui para permitir ver o valor antes do "=" se necessário
        return;
      }

      // 4. Categoria: OPERADORES (+, -, ×, ÷, √)
      if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        if (operation.isNotEmpty && !resetVisor) {
          // Se já tem uma operação pendente e o usuário digitou um número, calcula o intermediário
          _calculate();
        }
        firstNumber = visor;
        operation = buttonText;
        resetVisor = true;
        return;
      }

      if (buttonText == "√") {
        double val = double.tryParse(visor) ?? 0.0;
        if (val >= 0) {
          visor = _formatResult(sqrt(val));
        } else {
          visor = "Erro";
        }
        resetVisor = true;
        return;
      }

      // 5. Categoria: IGUAL (=)
      if (buttonText == "=") {
        _calculate();
        return;
      }

      // 6. Categoria: NÚMEROS E PONTO
      if (buttonText == "00") {
        if (visor == "0" || resetVisor) {
          visor = "0";
          resetVisor = false;
          return;
        }
      }

      if (resetVisor || visor == "0" || visor == "Erro") {
        if (buttonText == ".") {
          visor = "0.";
        } else {
          visor = buttonText;
        }
        resetVisor = false;
      } else {
        if (buttonText == "." && visor.contains(".")) return;
        visor += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:
            Colors.lightBlue.shade300, // Azul claro do fundo da imagem
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
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // LINHA 1 (Toda Rosa)
                      Expanded(
                        child: ButtonRow(
                          labels: const ["MRC", "M-", "M+", "√", "%"],
                          onClick: updateVisor,
                          buttonColor: Colors.pink.shade100,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // LINHA 2 (Toda Amarela)
                      Expanded(
                        child: ButtonRow(
                          labels: const ["->", "7", "8", "9", "÷"],
                          onClick: updateVisor,
                          buttonColor: Colors.yellow.shade200,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // LINHA 3 (Laranja e Verde)
                      Expanded(
                        child: ButtonRow(
                          labels: const ["CE", "4", "5", "6", "×"],
                          onClick: updateVisor,
                          buttonColor: Colors.lightGreen.shade200,
                          colorOverrides: {"CE": Colors.deepOrange.shade300},
                        ),
                      ),
                      const SizedBox(height: 8),
                      // LINHA 4 (Laranja e Roxo)
                      Expanded(
                        child: ButtonRow(
                          labels: const ["AC", "1", "2", "3", "-"],
                          onClick: updateVisor,
                          buttonColor: Colors.purple.shade100,
                          colorOverrides: {"AC": Colors.deepOrange.shade300},
                        ),
                      ),
                      const SizedBox(height: 8),
                      // LINHA 5 (Toda Branca)
                      Expanded(
                        child: ButtonRow(
                          labels: const ["0", "00", ".", "=", "+"],
                          onClick: updateVisor,
                          buttonColor: Colors.lightBlue.shade100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFC7D095), // Cor acinzentada do visor na imagem
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
              fontWeight: FontWeight.w400,
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
  final Map<String, Color>?
  colorOverrides; // Permite mudar a cor de botões específicos

  const ButtonRow({
    super.key,
    required this.labels,
    required this.onClick,
    required this.buttonColor,
    this.colorOverrides,
  });

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
                      elevation:
                          4, // Diminuí um pouco a sombra para ficar mais parecido com a foto
                      shadowColor: Colors.black45,
                      // Aqui ele checa se o botão tem uma cor especial. Se não tiver, usa a cor padrão da linha.
                      backgroundColor: colorOverrides?[label] ?? buttonColor,
                      foregroundColor: Colors.black87,
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.varelaRound(
                        fontSize: 22,
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
