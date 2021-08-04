import 'package:flutter/material.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/styles/k_colors.dart';

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
        primarySwatch: KColors.createMaterialColor(KColors.primary),
      ),
      home: LoginScreen(),
    );
  }
}
