import 'package:flutter/material.dart';


import 'package:letras/database/databasehelper.dart';
import 'package:letras/models/cancion.dart';
import 'package:letras/estilo_idioma/detallecancion.dart';


class listacanciones extends StatefulWidget {
  const listacanciones({Key? key}) : super(key: key);

  @override
  _listacancionesState createState() => _listacancionesState();
}

class _listacancionesState extends State<listacanciones> {
  late Future<List<Cancion>> _canciones;

  @override
  void initState() {
    super.initState();
    cargarCanciones();
  }

  void cargarCanciones() {
    setState(() {
      _canciones = databasehelper.instance.gettodaslascanciones();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canciones Guardadas'),
      ),
      body: FutureBuilder<List<Cancion>>(
        future: _canciones,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay canciones guardadas.'));
          }

          final canciones=snapshot.data!;

          return ListView.builder(
            itemCount: canciones.length,
            itemBuilder: (context, index) {
              final cancion= canciones[index];
              return ListTile(
                title: Text(cancion.titulo),
                subtitle: Text(cancion.artista),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleCancion(
                        titulo: cancion.titulo,
                        artista: cancion.artista,
                        letra: cancion.lyrics,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
