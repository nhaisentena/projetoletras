import 'package:flutter/material.dart';
import 'package:letras/models/cancion.dart';
import 'package:letras/database/cancionAPI.dart';

class agregarcancion extends StatefulWidget {
  final Function(Cancion) onSave;

  const agregarcancion({Key? key, required this.onSave}) : super(key: key);

  @override
  _agregarcancionState createState() => _agregarcancionState();
}

class _agregarcancionState extends State<agregarcancion> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _artistaController = TextEditingController();
  final TextEditingController _lyricsController = TextEditingController();

  bool _isLoading = false;

  void saveCancion() async {
    setState(() {
      _isLoading = true;
    });

    final lyrics = await LyricsAPI.fetchLyrics(
      _artistaController.text,
      _tituloController.text,
    );

    _lyricsController.text = lyrics ?? 'No se encontraron letras.';

    final cancion = Cancion(
      titulo: _tituloController.text,
      artista: _artistaController.text,
      lyrics: _lyricsController.text,
    );

    widget.onSave(cancion);

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Canción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _artistaController,
              decoration: const InputDecoration(labelText: 'Artista'),
            ),
            TextField(
              controller: _lyricsController,
              decoration: const InputDecoration(labelText: 'Letra'),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: saveCancion,
                child: const Text('Guardar'),
              ),
          ],
        ),
      ),
    );
  }
}
