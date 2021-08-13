enum KThemeMode {
  LIGHT,
  DARK,
}

class KTheme {
  static var kThemeMode = KThemeMode.DARK;

  static bool darkMode() {
    if (kThemeMode == KThemeMode.LIGHT) {
      return true;
    } else {
      return false;
    }
  }
}
