import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
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
    final asyncUser = ref.watch(authStateChangesProvider);

    return asyncUser.when(
      data: (user) => user != null ? HomeScreen() : WelcomeScreen(),
      loading: () => WelcomeScreen(),
      error: (e, stackTrace) => ErrorScreen(),
    );
  }
}
