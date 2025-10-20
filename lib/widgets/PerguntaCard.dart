import 'package:flutter/material.dart';

class PerguntaCard extends StatelessWidget{
  final int num1;
  final int num2;

  const PerguntaCard({super.key, required this.num1, required this.num2});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          '$num1 × $num2 = ?',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}