import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:treino_tabuada/services/JogadorService.dart';
import 'package:treino_tabuada/views/LoginView.dart';
import 'package:treino_tabuada/widgets/PerguntaCard.dart';
import 'package:treino_tabuada/widgets/TempoDisplay.dart';

import '../models/Jogador.dart';
import 'RankingView.dart';

class JogoView extends StatefulWidget{
  final Jogador jogador;
  const JogoView({super.key, required this.jogador});

  @override
  State<JogoView> createState() => _JogoViewState();
}

class _JogoViewState extends State<JogoView> {
  final TextEditingController _respostaController = TextEditingController();
  late int _num1;
  late int _num2;
  late int _tempoRestante;
  late int _tempoRestateAux;
  Timer? _timer;
  int _contagemErros = 0;

  @override
  void initState() {
    super.initState();
    _gerarPergunta();
    _tempoRestante = 20;
    _tempoRestateAux = _tempoRestante;
    _startTimer();
  }

  void _gerarPergunta(){
    final random = Random();
    setState(() {
      _num1 = random.nextInt(10) + 1;
      _num2 = random.nextInt(10) + 1;
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _tempoRestateAux--;
        if (_tempoRestateAux <= 0) {
          _handleErro();
          _zerarTimer();
        }
      });
    });
  }

  void _handleEnviar() {
    final resposta = int.tryParse(_respostaController.text);
    if (resposta == _num1 * _num2) {
      _handleAcerto();
    } else {
      _handleErro();
    }
  }

  void _handleAcerto() async {
    widget.jogador.acertar();
    _contagemErros = 0;
    if (_tempoRestante > 5) _tempoRestante -= 1;
    _tempoRestateAux = _tempoRestante;
    await JogadorService.salvarJogador(widget.jogador);
    _proximaPergunta();
    _zerarTimer();
  }

  void _handleErro() async {
    widget.jogador.errar();
    _contagemErros++;
    if (_contagemErros >= 2) _tempoRestante += 2;
    _tempoRestateAux = _tempoRestante;
    await JogadorService.salvarJogador(widget.jogador);
    _proximaPergunta();
    _zerarTimer();
  }

  void _proximaPergunta() {
    _respostaController.clear();
    _gerarPergunta();
    _startTimer();
  }

  void _zerarTimer(){
    _timer?.cancel();
    _startTimer();
  }

  void _resetPontuacao() async {
    await JogadorService.resetarJogador(widget.jogador.nome);
    setState(() {

      widget.jogador.acerto = 0;
      widget.jogador.erro = 0;
    });
  }

  void _sairJogo() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
          (Route<dynamic> route) => false,
    );
  }

  void _abrirRanking() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RankingView()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogador: ${widget.jogador.nome}'),
        actions: [
          IconButton(onPressed: _resetPontuacao, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: _sairJogo, icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TempoDisplay(tempoRestante: _tempoRestateAux),
            PerguntaCard(num1: _num1, num2: _num2),
            TextField(
              controller: _respostaController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onSubmitted: (_) => _handleEnviar(),
              decoration: const InputDecoration(labelText: 'Sua resposta'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _handleEnviar, child: const Text('Responder')),
            const SizedBox(height: 40),
            Text('Acertos: ${widget.jogador.acerto} | Erros: ${widget.jogador.erro}'),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _abrirRanking, child: const Text('Ver Ranking')),
          ],
        ),
      ),
    );
  }
}