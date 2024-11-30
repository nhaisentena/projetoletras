import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:letras/models/cancion.dart';


class CancionDatabase {
  static Future<Database> initDB() async {
    final dbPath= await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'canciones.db'),
      onCreate: (db, version) {

        return db.execute(
          'CREATE TABLE Cancion(id INTEGER PRIMARY KEY, titulo TEXT, artista TEXT, lyrics TEXT)',
        );
      },
      version: 1,
    );
  }



  static Future<void> insertCancion(Cancion cancion) async {
    final db=await initDB();
    await db.insert('canciones', cancion.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Cancion>> getCanciones() async {
    final db=await initDB();
    final List<Map<String, dynamic>> maps=await db.query('canciones');
    return List.generate(maps.length, (i) => Cancion.fromMap(maps[i]));
  }

  static Future<void> deleteSong(int id) async {
    final db= await initDB();
    await db.delete('canciones', where: 'id = ?', whereArgs: [id]);
  }
}