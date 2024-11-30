import 'package:flutter/material.dart'; 
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; 
import 'package:letras/database/databasehelper.dart'; 
import 'package:letras/paginas/listacanciones.dart'; 
import 'package:letras/paginas/agregarcancion.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory= databaseFactoryFfiWeb;
  } else {
    if (Platform.isLinux || Platform.isWindows) {
      databaseFactory= databaseFactoryFfi;
      sqfliteFfiInit();
    }
  }



  var db= await openDatabase(inMemoryDatabasePath);
  print((await db.rawQuery('SELECT sqlite_version()')).first.values.first);
  await db.close();

  runApp(MyApp());
}







class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Letras de Canciones',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(), 
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Letras de Canciones')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => agregarcancion(
                      onSave: (cancion) async {
                        await databasehelper.instance.addCancion(cancion);
                        print( 'Canción guardada: ${cancion.titulo}, ${cancion.artista}');
                      },
                    ),
                  ),
                );
              },
              child: const Text('Agregar Canción'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const listacanciones()),
                );
              },
              child: const Text('Ver Canciones Guardadas'),
            ),
          ],
        ),
      ),
    );
  }
}
