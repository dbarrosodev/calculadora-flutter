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
  String calculatorMemory = "0";
  bool resetVisor = false;

  void updateVisor(String buttonText) {
    setState(() {
      // 1. Categoria: LIMPEZA (AC e CE)
      if (buttonText == "AC") {
        visor = "0";
        firstNumber = "";
        operation = "";
        secondNumber = "";
        calculatorMemory = "0";
        resetVisor = false;
        return;
      }

      if (buttonText == "CE") {
        visor = "0";
        return;
      }

      // 2. Categoria: MEMÓRIA
      if (buttonText == "M+") {
        double mem = double.tryParse(calculatorMemory) ?? 0.0;
        double val = double.tryParse(visor) ?? 0.0;
        calculatorMemory = (mem + val).toString();
        resetVisor = true;
        return;
      }

      if (buttonText == "M-") {
        double mem = double.tryParse(calculatorMemory) ?? 0.0;
        double val = double.tryParse(visor) ?? 0.0;
        calculatorMemory = (mem - val).toString();
        resetVisor = true;
        return;
      }

      if (buttonText == "MRC") {
        visor = calculatorMemory;
        resetVisor = true;
        return;
      }

      // 3. Categoria: BOTÕES ESPECIAIS
      if (buttonText == "->") {
        // Apagar último caractere
        if (visor.length > 1) {
          visor = visor.substring(0, visor.length - 1);
        } else {
          visor = "0";
        }
        return;
      }

      if (buttonText == "%") {
        // Porcentagem simples
        double val = double.tryParse(visor) ?? 0.0;
        visor = (val / 100).toStringAsFixed(2);
        resetVisor = true;
        return;
      }

      // 4. Categoria: OPERADORES (+, -, ×, ÷, √)
      if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        // Só salva o firstNumber se o visor tiver um número válido
        double? parsed = double.tryParse(visor);
        if (parsed != null) {
          firstNumber = visor;
        }

        operation = buttonText;
        resetVisor = true;
        visor = buttonText; // Mostra o operador na tela temporariamente
        return;
      }

      if (buttonText == "√") {
        double val = double.tryParse(visor) ?? 0.0;
        if (val >= 0) {
          visor = sqrt(val).toStringAsFixed(2);
        } else {
          visor = "Erro"; // Proteção contra número negativo
        }
        resetVisor = true;
        return;
      }

      // 5. Categoria: IGUAL (=)
      if (buttonText == "=") {
        if (operation.isEmpty || firstNumber.isEmpty) return;

        secondNumber = visor;

        double num1 = double.tryParse(firstNumber) ?? 0.0;
        double num2 = double.tryParse(secondNumber) ?? 0.0;
        double result = 0.0;

        if (operation == "+") result = num1 + num2;
        if (operation == "-") result = num1 - num2;
        if (operation == "×") result = num1 * num2;
        if (operation == "÷") result = num2 != 0 ? (num1 / num2) : 0;

        visor = result.toStringAsFixed(2);
        operation = "";
        resetVisor = true;
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

      if (resetVisor || visor == "0") {
        // Se for começar com ".", coloca um 0 antes
        if (buttonText == ".") {
          visor = "0.";
        } else {
          visor = buttonText;
        }
        resetVisor = false;
      } else {
        // Impede que o usuário coloque vários pontos (ex: 3.5.2)
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
            Colors.lightBlue.shade100, // Azul claro do fundo da imagem
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
                          buttonColor: Colors.white,
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
