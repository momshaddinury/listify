import 'package:flutter/material.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/auth/welcome_screen.dart';
import 'package:listify/views/styles/k_colors.dart';
import 'package:listify/views/styles/k_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listify',
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: KTheme.darkMode() ? KColors.spaceCadet : KColors.white,
        scaffoldBackgroundColor: KTheme.darkMode() ? KColors.spaceCadet : KColors.white,
        brightness: KTheme.darkMode() ? Brightness.dark : Brightness.light,
        primaryColor: KColors.primary,
        accentColor: KColors.accent,
        primarySwatch: KColors.createMaterialColor(KColors.primary),
      ),
      home: WelcomeScreen(),
    );
  }
}
