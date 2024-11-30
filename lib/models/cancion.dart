class Cancion {
  final int? id;
  final String titulo;
  final String artista;
  final String lyrics;

  Cancion({
    this.id,
    required this.titulo,
    required this.artista,
    required this.lyrics,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'artista': artista,
      'lyrics': lyrics,
    };
  }



  factory Cancion.fromMap(Map<String, dynamic> map) {
    return Cancion(
      id: map['id'],
      titulo: map['titulo'],
      artista: map['artista'],
      lyrics: map['lyrics'],
    );
  }
}
