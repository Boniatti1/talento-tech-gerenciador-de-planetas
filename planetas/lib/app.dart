import 'package:flutter/material.dart';
import 'list.dart';
import 'modal.dart';
import 'planet.dart';
import 'database.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var planets = PlanetDB().planets();

  // void _AddPlanet(nome, descricao, distancia, diametro) {
  //   setState(() {
  //     planets.add(Planet(
  //         id: planets.isEmpty ? 1 : planets.last.id! + 1,
  //         nome: nome,
  //         descricao: descricao,
  //         diametro: diametro,
  //         distancia: distancia));
  //   });
  // }

  void loadPlanets() {
    setState(() {
      planets = PlanetDB().planets();
    });
  }

  void _openModal() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => PlanetModal(newSubmitFunction: (planet) async {
        await PlanetDB().insertPlanet(planet);
        loadPlanets();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Planetas"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Planet>>(
          future: planets,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListLayout(
                planets: snapshot.data!,
                reloadStateCallback: loadPlanets,
                dbInstance: PlanetDB(),
              );
            } else {
              return Center(child: Text("Nenhum planeta encontrado"));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openModal(),
        child: Icon(Icons.add),
      ),
    );
  }
}
