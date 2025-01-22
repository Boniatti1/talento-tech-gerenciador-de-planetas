import 'package:flutter/material.dart';
import 'planet.dart';

class PlanetModalUpdate extends StatefulWidget {
  Planet planet;
  Function updatePlanet;
  Function reloadStateCallback;

  PlanetModalUpdate({
    required this.planet,
    required this.reloadStateCallback,
    required this.updatePlanet,
    super.key,
  });

  @override
  State<PlanetModalUpdate> createState() => _PlanetModalUpdateState();
}

class _PlanetModalUpdateState extends State<PlanetModalUpdate> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _diametroController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.planet.nome;
    _descricaoController.text = widget.planet.descricao;
    _distanciaController.text = widget.planet.distancia.toString();
    _diametroController.text = widget.planet.diametro.toString();
    print("carregou informações dos planetas para o modal");
  }

  _submitForm() {
    final nome = _nomeController.text;
    final descricao = _descricaoController.text;
    final distancia = double.tryParse(_distanciaController.text) ?? 0;
    final diametro = double.tryParse(_diametroController.text) ?? 0;

    if (nome.isEmpty || descricao.isEmpty || distancia == 0 || diametro == 0) {
      return;
    }

    Navigator.of(context).pop();

    int id = widget.planet.id!;
    Planet updatedPlanet = Planet(
      id: id,
      nome: nome,
      descricao: descricao,
      distancia: distancia,
      diametro: diametro,
    );

    widget.updatePlanet(updatedPlanet);

    widget.reloadStateCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: _distanciaController,
            decoration: InputDecoration(labelText: 'Distância'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: _diametroController,
            decoration: InputDecoration(labelText: 'Diâmetro'),
          ),
        ),
        TextButton(onPressed: _submitForm, child: Text("Salvar"))
      ],
    );
  }
}
