import 'package:flutter/material.dart';
import 'package:planetas/services/database.dart';

class PlanetModal extends StatefulWidget {
  final Function callback;

  const PlanetModal({required this.callback, super.key});

  // Abre o modal para adicionar um novo planeta
  // O método estático permite chamar o modal sem instanciar um objeto da classe
  static void openModal(
      {required BuildContext context, required Function callback}) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: PlanetModal(callback: callback),
      ),
    );
  }

  @override
  State<PlanetModal> createState() => _PlanetModalState();
}

class _PlanetModalState extends State<PlanetModal> {
  // Controladores para o texto dos campos
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _diametroController = TextEditingController();

  // Função chamada ao clicar em salvar. Verifica se todos os campos foram preenchidos
  // Se tudo estiver correto, chama a função de inserção de dados e fecha a caixa de diálogo
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

    final planetData = {
      'nome': nome,
      'descricao': descricao,
      'distancia': distancia,
      'diametro': diametro,
    };

    Navigator.of(context).pop();

    _submitFunction(planetData);
  }

  // Inserção do planeta na base de dados e atualização da lista com o callback
  _submitFunction(Map<String, Object> planetData) async {
    await PlanetDB().insertPlanet(planetData);
    widget.callback();
  }

  // Layout com o SingleChildScrollView, ajusta automáticamente o tamanho do formulário
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              decoration: InputDecoration(labelText: 'Distância da Terra em U.A.'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: _diametroController,
              decoration: InputDecoration(labelText: 'Diâmetro em km'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          TextButton(onPressed: _submitForm, child: Text("Salvar"))
        ],
      ),
    );
  }
}
