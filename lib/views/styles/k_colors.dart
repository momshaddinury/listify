import 'package:flutter/material.dart';

class KColors {
  static const primary = Color(0xFF299E8D);
  static const accent = Color(0x1F299E8D);
  static const darkAccent = Color(0xFF2C4251);
  static const white = Colors.white;
  static const black = Colors.black;
  static final charcoal = Color(0xFF264654);
  static final lightCharcoal = charcoal.withOpacity(.12);
  static const spaceCadet = Color(0xFF2C3549);
  static final lightRed = Colors.red[100];
  static final red = Colors.red;
  static final transparent = Colors.transparent;

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
