class UserRanking {
  final String? nome;
  final int? pontuacao;

  UserRanking({
    this.nome,
    this.pontuacao,
  });

  static UserRanking mapToEntity(Map<String, dynamic> map) {
    return UserRanking(
      pontuacao: map['pontuacao'],
      nome: map['nome']
    );
  }
}