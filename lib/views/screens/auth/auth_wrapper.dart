import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_controller.dart';
import 'package:listify/views/screens/home_screen.dart';
import 'package:listify/views/screens/startup/welcome_screen.dart';
import 'package:listify/views/widgets/error_widget.dart';

class AuthenticationWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final asyncUser = watch(authStateChangesProvider);
    return asyncUser.when(
      data: (user) => user != null ? HomeScreen() : WelcomeScreen(),
      loading: () => WelcomeScreen(),
      error: (e, stackTrace) => KErrorWidget(),
    );
  }
}