import 'dart:convert';

import 'package:http/http.dart' as http;

class LyricsAPI {

  static const String baseUrl= 'https://api.lyrics.ovh/v1';

  static Future<String?> fetchLyrics(String artist, String title) async {
    final url= Uri.parse('$baseUrl/$artist/$title');


    try {
      final response=await http.get(url);

      if (response.statusCode==200) {
        final data= jsonDecode(response.body);
        return data['lyrics'];
      } else {
        return 'No se encontraron letras para esta canción.';
      }
    } catch (e) {
      return 'Error al conectarse a la API de Lyrics.ovh.';
    }
  }
}
