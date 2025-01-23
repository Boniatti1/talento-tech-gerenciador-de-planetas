import 'package:flutter/material.dart';
import 'package:planetas/models/planet.dart';
import 'modalUpdate.dart';

class ListLayout extends StatefulWidget {
  const ListLayout({
    required this.planets,
    required this.callback,
    super.key,
  });

  final List<Planet> planets;
  final Function callback;

  @override
  State<ListLayout> createState() => _ListLayoutState();
}

class _ListLayoutState extends State<ListLayout> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 5,
        children: [
          ...widget.planets.map(
            (planet) => InkWell(
              onTap: () => PlanetModalUpdate.openModalUpdate(
                  planet: planet, callback: widget.callback, context: context),
              child: ListTilePlanet(
                nome: planet.nome,
                apelido: planet.descricao,
                distancia: planet.distancia,
                diametro: planet.diametro,
              ),
            ),
          )
        ],
      ),
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
      color: const Color.fromARGB(90, 0, 0, 0),
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
                    style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 192, 192, 192)),
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
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(211, 181, 201, 243)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$diametro km",
                    style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: const Color.fromARGB(186, 189, 186, 219)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
