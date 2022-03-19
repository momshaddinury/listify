import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
import 'package:listify/services/network_status.dart';
import 'package:listify/views/screens/home_screen.dart';
import 'package:listify/views/screens/k_base_screen.dart';
import 'package:listify/views/screens/startup/welcome_screen.dart';
import 'package:listify/views/screens/error_screen.dart';

class AuthenticationWrapper extends KBaseScreen {
  @override
  KBaseState<AuthenticationWrapper> createState() =>
      _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends KBaseState<AuthenticationWrapper> {
  @override
  bool scrollable() => false;

  @override
  bool defaultPadding() => false;

  @override
  Widget body() {
<<<<<<< Updated upstream
    final asyncUser = ref.watch(authStateChangesProvider);

    return asyncUser.when(
      data: (user) {
        return user != null ? HomeScreen() : WelcomeScreen();
      },
      loading: () => WelcomeScreen(),
      error: (e, stackTrace) => ErrorScreen(),
    );
=======
    return ref.watch(authStateChangesProvider).when(
          data: (user) {
            return user != null ? HomeScreen() : WelcomeScreen();
          },
          loading: () => WelcomeScreen(),
          error: (e, stackTrace) => ErrorScreen(),
        );
>>>>>>> Stashed changes
  }
}
