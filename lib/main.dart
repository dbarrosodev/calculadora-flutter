import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Screen(valor: "0"),
            SizedBox(height: 40),
            ButtonRow(labels: ["CE", "AC"]),
            SizedBox(height: 10),
            ButtonRow(labels: ["M+", "M-", "MRC", "GT", "->"]),
            SizedBox(height: 10),
            ButtonRow(labels: ["7", "8", "9", "÷", "√"]),
            SizedBox(height: 10),
            ButtonRow(labels: ["4", "5", "6", "×", "%"]),
            SizedBox(height: 10),
            ButtonRow(labels: ["1", "2", "3", "-", "MU"]),
            SizedBox(height: 10),
            ButtonRow(labels: ["0", "00", ".", "+", "="]),
            SizedBox(height: 100)
          ]
        ),
      ),
    );
  }
}

class Screen extends StatelessWidget {
  final String valor;

  const Screen({super.key, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20)
      ),
      width: MediaQuery.of(context).size.width/1.05,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      alignment: Alignment.centerRight,
      child: Text(
        valor,
        style: const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w300, 
          color: Colors.white
        ),
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  final List<String> labels;

  const ButtonRow({super.key, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: labels.map((label) => ElevatedButton(
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
          fixedSize: Size(60, 60),
          padding: const EdgeInsets.all(0)
        ),
        child: Text(label, softWrap: false, overflow: TextOverflow.visible, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      )).toList(),
    );
  }
}
