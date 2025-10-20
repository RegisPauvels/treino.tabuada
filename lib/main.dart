import 'package:flutter/material.dart';
import 'package:treino_tabuada/views/LoginView.dart';


void main() {
  runApp(const TabuadaApp());
}

class TabuadaApp extends StatelessWidget {
  const TabuadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Tabuada',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginView(),
    );
  }
}
