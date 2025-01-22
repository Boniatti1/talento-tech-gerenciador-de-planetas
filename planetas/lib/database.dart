import 'dart:async';
import 'planet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PlanetDB {
  // WidgetsFlutterBinding.ensureInitialized();
  late final Future<Database> database;

  PlanetDB() {
    database = _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'planetas.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE planetas(id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT, distancia REAL, diametro REAL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertPlanet(Map<String, dynamic> planet) async {
    final db = await database;

    await db.insert(
      'planetas',
      planet,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(await "jksdhkjsahdfddasdasdfsd");
  }

  Future<List<Planet>> planets() async {
    final db = await database;

    final List<Map<String, dynamic>> planetMaps = await db.query('planetas');

    return [
      for (var planetMap in planetMaps)
        Planet(
          id: planetMap['id'],
          nome: planetMap['nome'],
          descricao: planetMap['descricao'],
          distancia: planetMap['distancia'],
          diametro: planetMap['diametro'],
        ),
    ];
  }

  Future<void> updatePlanet(Planet planet) async {
    final db = await database;

    await db.update(
      'planetas',
      planet.toMap(),
      where: 'id = ?',
      whereArgs: [planet.id],
    );
  }

  Future<void> deletePlanet(int id) async {
    final db = await database;

    await db.delete(
      'planetas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
