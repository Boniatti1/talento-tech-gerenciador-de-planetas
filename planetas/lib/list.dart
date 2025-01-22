import 'package:flutter/material.dart';
import 'package:planetas/planet.dart';
import 'modal.dart';
import 'modalUpdate.dart';

class ListLayout extends StatefulWidget {
  ListLayout({required this.planets, super.key});
  List<Planet> planets;

  @override
  State<ListLayout> createState() => _ListLayoutState();
}

class _ListLayoutState extends State<ListLayout> {
  
  void reloadStateCallback() {
    setState(() {});
  }

  void _openModalUpdate(Planet planet) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => PlanetModalUpdate(
        planet: planet,
        planetsList: widget.planets,
        reloadStateCallback: reloadStateCallback,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.planets.map(
          (planet) => InkWell(
            onTap: () => _openModalUpdate(planet),
            child: ListTilePlanet(
              nome: planet.nome,
              apelido: planet.descricao,
              distancia: planet.distancia,
              diametro: planet.diametro,
            ),
          ),
        )
      ],
    );
  }
}

class ListTilePlanet extends StatelessWidget {
  const ListTilePlanet({
    super.key,
    required this.nome,
    required this.apelido,
    required this.distancia,
    required this.diametro,
  });

  final String nome;
  final String apelido;
  final double distancia;
  final double diametro;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(99, 58, 49, 49),
      margin: EdgeInsets.all(2),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style: TextStyle(fontSize: 20),
                    nome,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.color!
                            .withValues(alpha: 0.5)),
                    apelido,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$distancia U.A.",
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$diametro km",
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
