import 'package:flutter/material.dart';
import 'package:treino_tabuada/services/JogadorService.dart';

import 'JogoView.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _controller = TextEditingController();

  void _iniciarJogo() async {
    final nome = _controller.text.trim();
    if (nome.isEmpty) return;

    final jogador = await JogadorService.buscarOuCriarJogador(nome);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => JogoView(jogador: jogador)),
    );
  }

  void _fecharApp(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jogo da Tabuada'),
        actions: [
          IconButton(onPressed: _fecharApp, icon: const Icon(Icons.exit_to_app)),
        ],),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Digite seu nome para começar'),
            TextField(controller: _controller, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _iniciarJogo, child: const Text('Começar')),
          ],
        ),
      ),
    );
  }

}