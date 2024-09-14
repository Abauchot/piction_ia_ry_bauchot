import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.deepPurple,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9E4770),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(
            color: Colors.white,
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 18.0,
        ),
      ),
    ),
  );
}