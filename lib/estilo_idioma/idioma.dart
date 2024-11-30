enum Idioma { espanol, portugues }

class Idiomas {
  static final titulo= {
    Idioma.espanol: 'Letras de Canciones',
    Idioma.portugues: 'Letras de Músicas',
  };

  static final descripcion={
    Idioma.espanol:
        '¡Guarda las letras de todas tus canciones preferidas sólamente ingresando su Título y Artista!',
        
    Idioma.portugues:
        'Salve as letras de suas músicas favoritas apenas inserindo o Título e o Artista!',
  };

  static final agregar= {
    Idioma.espanol: 'Agregar Canción',
    Idioma.portugues: 'Adicionar Música',
  };

  static final verGuardadas= {
    Idioma.espanol: 'Ver Canciones Guardadas',
    Idioma.portugues: 'Ver Músicas Salvas',
  };
}
