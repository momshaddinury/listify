import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
import 'package:listify/views/screens/home_screen.dart';
import 'package:listify/views/screens/startup/welcome_screen.dart';
import 'package:listify/views/screens/error_screen.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final asyncUser = ref.watch(authStateChangesProvider);

    return asyncUser.when(
      data: (user) => user != null ? HomeScreen() : WelcomeScreen(),
      loading: () => WelcomeScreen(),
      error: (e, stackTrace) => ErrorScreen(),
    );
  }
}
