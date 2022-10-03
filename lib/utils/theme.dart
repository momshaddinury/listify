import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

enum ThemeMode {
  LIGHT,
  DARK,
}

class ListifyTheme {
  static var kThemeMode = ThemeMode.LIGHT;

  static bool darkMode() {
    if (kThemeMode == ThemeMode.DARK) {
      return true;
    } else {
      return false;
    }
  }
}

ThemeData themeData = ThemeData(
  backgroundColor:
      ListifyTheme.darkMode() ? ListifyColors.spaceCadet : ListifyColors.white,
  scaffoldBackgroundColor:
      ListifyTheme.darkMode() ? ListifyColors.spaceCadet : ListifyColors.white,
  brightness: ListifyTheme.darkMode() ? Brightness.dark : Brightness.light,
  primaryColor: ListifyColors.primary,
  colorScheme:
      ThemeData().colorScheme.copyWith(secondary: ListifyColors.accent),
  primarySwatch: ListifyColors.createMaterialColor(ListifyColors.primary),
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(size: 16),
      actionsIconTheme: IconThemeData(size: 16),
      backgroundColor: ListifyColors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: ListifyColors.charcoal,
        fontWeight: FontWeight.w500,
      )),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
);
