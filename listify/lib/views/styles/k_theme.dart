enum KThemeMode {
  LIGHT,
  DARK,
}

class KTheme {
  static var kThemeMode = KThemeMode.LIGHT;

  static bool darkMode() {
    if (kThemeMode == KThemeMode.DARK) {
      return true;
    } else {
      return false;
    }
  }
}
