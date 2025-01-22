import 'package:flutter/material.dart';

class PlanetModal extends StatefulWidget {
  Function newSubmitFunction;

  PlanetModal({required this.newSubmitFunction, super.key});

  @override
  State<PlanetModal> createState() => _PlanetModalState();
}

class _PlanetModalState extends State<PlanetModal> {

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _diametroController = TextEditingController();

  _submitForm() {
    final nome = _nomeController.text;
    final descricao = _descricaoController.text;
    final distancia = double.tryParse(_distanciaController.text) ?? 0;
    final diametro = double.tryParse(_diametroController.text) ?? 0;

    if (nome.isEmpty || descricao.isEmpty || distancia == 0 || diametro == 0) {
      return;
    }

    final planetData = {
      'nome': nome,
      'descricao': descricao,
      'distancia': distancia,
      'diametro': diametro,
    };

    print(nome);
    print(descricao);
    print(diametro);

    Navigator.of(context).pop();
    widget.newSubmitFunction(planetData);
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
