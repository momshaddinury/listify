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
