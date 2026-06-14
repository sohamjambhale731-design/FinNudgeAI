import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(
      0xFF0D1117,
    ),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF7C5CFF),
      secondary: Color(0xFF00D09E),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,

      fillColor: const Color(
        0xFF161B22,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );
}