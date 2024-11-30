import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


import 'package:letras/models/cancion.dart';


class databasehelper {
  static final databasehelper instance= databasehelper._init();

  static Database? _database;

  databasehelper._init();



  Future<Database> get database async {
    if (_database!=null) return _database!;
    _database= await _initDB('canciones.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath= await getDatabasesPath();
    final pathToDB= join(dbPath, path);

    return await openDatabase(pathToDB, version: 1, onCreate: _onCreate);
  }



  Future _onCreate(Database db, int version) async {
    const idType='INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType= 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE canciones (
        id $idType,
        titulo $textType,
        artista $textType,
        lyrics $textType
      )
    ''');
  }

  Future<int> addCancion(Cancion cancion) async {
    final db= await instance.database;
    return await db.insert('canciones', cancion.toMap());
  }

  Future<List<Cancion>> gettodaslascanciones() async {
    final db= await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('canciones');
    return List.generate(maps.length, (i) {
      return Cancion.fromMap(maps[i]);
    });
  }
}
