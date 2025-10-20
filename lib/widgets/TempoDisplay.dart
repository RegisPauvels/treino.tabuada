import 'package:flutter/material.dart';

class TempoDisplay extends StatelessWidget{
  final int tempoRestante;
  const TempoDisplay({super.key, required this.tempoRestante});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tempo: $tempoRestante s',
      style: TextStyle(
        fontSize: 24,
        color: tempoRestante <= 5 ? Colors.red : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}