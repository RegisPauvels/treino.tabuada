import 'package:flutter/material.dart';
import 'package:treino_tabuada/models/Jogador.dart';
import 'package:treino_tabuada/services/JogadorService.dart';

class RankingView extends StatefulWidget{
  const RankingView({super.key});

  @override
  State<RankingView> createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView>{
  List<Jogador> _ranking = [];

  @override
  void initState() {
    super.initState();
    _carregarRanking();
  }

  void _carregarRanking() async {
    final jogadores = await JogadorService.getRanking();

    setState(() {
      _ranking = jogadores;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ranking')),
      body: ListView.builder(
        itemCount: _ranking.length,
        itemBuilder: (context, index) {
          final p = _ranking[index];
          return ListTile(
            leading: Text('${index + 1}'),
            title: Text(p.nome),
            subtitle: Text('Acertos: ${p.acerto}, Erros: ${p.erro}'),
            trailing: Text('Pontuação: ${p.pontuacao}'),
          );
        },
      ),
    );
  }
}