class Jogador{
  String nome;
  int acerto;
  int erro;

  Jogador({
    required this.nome,
    this.acerto = 0,
    this.erro = 0,
 });

  int get pontuacao => acerto - erro;

  void acertar(){
    this.acerto++;
  }

  void errar(){
    this.erro++;
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'acerto': acerto,
      'erro': erro,
    };
  }

  factory Jogador.fromMap(Map<String, dynamic> map) {
    return Jogador(
      nome: map['nome'],
      acerto: map['acerto'],
      erro: map['erro'],
    );
  }
}