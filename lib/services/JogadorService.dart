import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treino_tabuada/models/Jogador.dart';

class JogadorService{
  static const _ChaveJogadores = 'jogadores_data';

  static Future<Map<String, Jogador>> _buscarTodosJogadores() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(_ChaveJogadores);
    if (jsonData == null) return {};
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.map((key, value) => MapEntry(key, Jogador.fromMap(value)));
  }

  static Future<void> _salvarTodosJogadores(Map<String, Jogador> jogadores) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(
      jogadores.map((key, player) => MapEntry(key, player.toMap())),
    );
    await prefs.setString(_ChaveJogadores, jsonData);
  }

  static Future<Jogador> buscarOuCriarJogador(String nome) async {
    final jogadores = await _buscarTodosJogadores();
    return jogadores[nome] ?? Jogador(nome: nome);
  }

  static Future<void> salvarJogador(Jogador jogador) async {
    final jogadores = await _buscarTodosJogadores();
    jogadores[jogador.nome] = jogador;
    await _salvarTodosJogadores(jogadores);
  }

  static Future<List<Jogador>> getRanking() async {
    final jogadores = await _buscarTodosJogadores();
    final list = jogadores.values.toList();
    list.sort((a, b) => b.pontuacao.compareTo(a.pontuacao));
    return list;
  }

  static Future<void> resetarJogador(String nome) async {
    final jogadores = await _buscarTodosJogadores();
    if (jogadores.containsKey(nome)) {
      jogadores[nome] = Jogador(nome: nome);
      await _salvarTodosJogadores(jogadores);
    }
  }


}