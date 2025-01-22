import 'dart:async';
import 'planet.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'planetas.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE planetas(id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT, distancia REAL, diametro REAL)',
      );
    },
    version: 1,
  );

  Future<void> insertPlanet(Planet planet) async {
    final db = await database;

    await db.insert(
      'planetas',
      planet.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Planet>> planets() async {
    final db = await database;

    final List<Map<String, Object?>> planetMaps = await db.query('planetas');

    return [
      for (final {
            'id': id as int,
            'nome': nome as String,
            'descricao': descricao as String,
            'distanca': distancia as double,
            'diametro': diametro as double,
          } in planetMaps)
        Planet(
          id: id,
          nome: nome,
          descricao: descricao,
          distancia: distancia,
          diametro: diametro,
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
