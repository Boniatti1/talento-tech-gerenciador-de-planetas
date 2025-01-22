class Planet {
  final int? id;
  final String nome;
  final String descricao;
  final double distancia;
  final double diametro;

  Planet({
    this.id,
    required this.nome,
    required this.descricao,
    required this.distancia,
    required this.diametro,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "descricao": descricao,
      "distancia": distancia,
      "diametro": diametro
    };
  }
}
