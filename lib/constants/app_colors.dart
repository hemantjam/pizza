import 'package:flutter/material.dart';

class AppColors {
  static Color lightOrange = const Color(0xFFFDAF17);
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color grey = Colors.grey;

  static MaterialColor primaryColor = const MaterialColor(
    0xFFFDAF17,
    <int, Color>{
      50: Color(0xFFFFFAE5),
      100: Color(0xFFFFF1B0),
      200: Color(0xFFFEE87A),
      300: Color(0xFFFDE144),
      400: Color(0xFFFDDB1D),
      500: Color(0xFFFDAF17), // The default shade
      600: Color(0xFFFCD105),
      700: Color(0xFFFCBE00),
      800: Color(0xFFFCB800),
      900: Color(0xFFFCAD00),
    },
  );
}
