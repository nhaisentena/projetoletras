import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:letras/database/databasehelper.dart';
import 'package:letras/paginas/listacanciones.dart';
import 'package:letras/paginas/agregarcancion.dart';

import 'dart:io';

import 'package:letras/estilo_idioma/estilo.dart';
import 'package:letras/estilo_idioma/idioma.dart';

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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Letras de Canciones',
      theme: Estilo.tema,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Idioma idiomaActual = Idioma.espanol;

  void cambiarIdioma(Idioma nuevoIdioma) {
    setState(() {
      idiomaActual=nuevoIdioma;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Idiomas.titulo[idiomaActual]!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lyrics',
              style: Estilo.titulo,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              Idiomas.descripcion[idiomaActual]!,
              style: Estilo.descripcion,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => agregarcancion(
                      onSave: (cancion) async {
                        await databasehelper.instance.addCancion(cancion);
                      },
                    ),
                  ),
                );
              },
              child: Text(Idiomas.agregar[idiomaActual]!),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => listacanciones()),
                );
              },
              child: Text(Idiomas.verGuardadas[idiomaActual]!),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => cambiarIdioma(Idioma.espanol),
                  child: const Text('Español'),
                ),
                TextButton(
                  onPressed: () => cambiarIdioma(Idioma.portugues),
                  child: const Text('Português'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
