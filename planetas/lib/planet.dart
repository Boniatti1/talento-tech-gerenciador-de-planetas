class Planet {
  int? id;
  String nome;
  String descricao;
  double distancia;
  double diametro;

  Planet({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.distancia,
    required this.diametro,
  });

  Map<String, Object> toMap() {
    return {
      "id": id,
      "nome": nome,
      "descricao": descricao,
      "distancia": distancia,
      "diametro": diametro
    };
  }
}
