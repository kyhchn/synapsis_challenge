import 'package:flutter/material.dart';

class SynapsisColor {
  static const MaterialColor primaryColor =
      MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFE4F4F9),
    100: Color(0xFFBCE3EF),
    200: Color(0xFF8FD0E4),
    300: Color(0xFF62BDD9),
    400: Color(0xFF41AED1),
    500: Color(_primaryValue),
    600: Color(0xFF1B98C3),
    700: Color(0xFF178EBC),
    800: Color(0xFF1284B5),
    900: Color(0xFF0A73A9),
  });
  static const int _primaryValue = 0xFF1FA0C9;

  static const Color primaryColorDark = Color(0xFF121212);
}
