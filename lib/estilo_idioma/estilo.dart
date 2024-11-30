import 'package:flutter/material.dart';
class Estilo {
  static final tema=ThemeData(
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.purple.shade50,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple.shade900,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
  );



  static final titulo= TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.purple.shade900,
  );

  static final descripcion=TextStyle(
    fontSize: 16,
    color: Colors.purple.shade700,
  );
}