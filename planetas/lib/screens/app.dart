import 'package:flutter/material.dart';
import 'list.dart';
import 'modal.dart';
import '../models/planet.dart';
import '../services/database.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var planets = PlanetDB().planets();

  // Função para atualizar a lista
  void loadPlanets() {
    setState(() {
      planets = PlanetDB().planets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Planetas"),
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      // Constrói a lista com base no estado da operação de busca na base de dados
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/fundo.jpg"), fit: BoxFit.cover)),
        child: FutureBuilder<List<Planet>>(
          future: planets,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(child: Text("Nenhum planeta encontrado"));
              } else {
                return ListLayout(
                  planets: snapshot.data!,
                  callback: loadPlanets,
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      // Botão flutuante para modal de inserção de planetas
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            PlanetModal.openModal(context: context, callback: loadPlanets),
        child: Icon(Icons.add),
      ),
    );
  }
}
