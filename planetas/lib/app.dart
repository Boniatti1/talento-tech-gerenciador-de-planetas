import 'package:flutter/material.dart';
import 'list.dart';
import 'modal.dart';
import 'planet.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var planets = [
    Planet(
        id: 1,
        nome: "Marte",
        descricao: "Planeta Vermelho",
        distancia: 2122343.0,
        diametro: 32434.0),
  ];

  void _AddPlanet(nome, descricao, distancia, diametro) {
    setState(() {
      planets.add(Planet(
          id: planets.isEmpty ? 1 : planets.last.id! + 1,
          nome: nome,
          descricao: descricao,
          diametro: diametro,
          distancia: distancia));
    });
  }

  void _openModal() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => PlanetModal(newSubmitFunction: _AddPlanet),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Planetas"),
        centerTitle: true,
      ),
      body: ListLayout(planets: planets),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openModal(),
        child: Icon(Icons.add),
      ),
    );
  }
}
