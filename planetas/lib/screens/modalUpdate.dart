import 'package:flutter/material.dart';
import 'package:planetas/services/database.dart';
import '../models/planet.dart';

class PlanetModalUpdate extends StatefulWidget {
  final Planet planet;
  final Function callback;

  const PlanetModalUpdate({
    required this.planet,
    super.key,
    required this.callback,
  });

  // Abre o modal para atualizar um dado planeta
  // O método estático permite chamar o modal sem instanciar um objeto da classe
  static void openModalUpdate({
    required Planet planet,
    required Function callback,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: PlanetModalUpdate(callback: callback, planet: planet),
      ),
    );
  }

  @override
  State<PlanetModalUpdate> createState() => _PlanetModalUpdateState();
}

class _PlanetModalUpdateState extends State<PlanetModalUpdate> {
  // Controladores para o texto dos campos
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _diametroController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Para a atualização, insere nos campos as informações do planeta atual
    _nomeController.text = widget.planet.nome;
    _descricaoController.text = widget.planet.descricao;
    _distanciaController.text = widget.planet.distancia.toString();
    _diametroController.text = widget.planet.diametro.toString();
  }

  // Função chamada ao clicar em salvar. Verifica se todos os campos foram preenchidos
  // Se tudo estiver correto, chama a função de atualização de dados e fecha a caixa de diálogo
  _submitForm() {
    // Pega o texto dos campos
    final nome = _nomeController.text;
    final descricao = _descricaoController.text;
    final distancia = double.tryParse(_distanciaController.text) ?? 0;
    final diametro = double.tryParse(_diametroController.text) ?? 0;

    // Verificação das informações
    if (nome.isEmpty || descricao.isEmpty || distancia == 0 || diametro == 0) {
      return;
    }

    int id = widget.planet.id!;
    Planet updatedPlanet = Planet(
      id: id,
      nome: nome,
      descricao: descricao,
      distancia: distancia,
      diametro: diametro,
    );

    Navigator.of(context).pop();

    _updateFunction(updatedPlanet);
  }

  // Atualização do planeta na base de dados e atualização da lista com o callback
  void _updateFunction(Planet planet) async {
    await PlanetDB().updatePlanet(planet);
    widget.callback();
  }

  // Função para confirmar e excluir o planeta
  void _deleteFunction(Planet planet) async {
    Navigator.of(context).pop();

    // Há confirmação adicional por uma caixa de alerta
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Excluir Planeta?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
            child: Text("Excluir"),
          ),
        ],
      ),
    );

    // Caso haja confirmação, exclui o planeta
    if (confirmDelete == true) {
      await PlanetDB().deletePlanet(planet.id!);
      widget.callback(); // Atualiza a lista de planetas
    }
  }

  // Constrói o formulário com um botão para exclusão
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        Column(
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
                decoration:
                    InputDecoration(labelText: 'Distância da Terra em U.A.'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _diametroController,
                decoration: InputDecoration(labelText: 'Diâmetro em km'),
              ),
            ),
            TextButton(onPressed: _submitForm, child: Text("Salvar"))
          ],
        ),
        Positioned(
            top: 7,
            right: 5,
            child: IconButton(
                color: Colors.red,
                onPressed: () => _deleteFunction(widget.planet),
                iconSize: 25,
                icon: Icon(
                  Icons.delete_outline,
                )))
      ]),
    );
  }
}
