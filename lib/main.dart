import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listify/utils/navigation.dart';
import 'package:listify/views/screens/startup/splash_screen.dart';
import 'package:listify/utils/colors.dart';
import 'package:listify/utils/theme.dart';
import 'package:nb_utils/nb_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializing shared preference via nb_utils package
  await initialize();

  /// Initialize firebase
  await Firebase.initializeApp();

  /// A widget that stores the state of providers.
  /// All Flutter applications using Riverpod must contain a [ProviderScope] at
  /// the root of their widget tree
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Hide Keyboard
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return MaterialApp(
      title: 'Listify',
      navigatorKey: Navigation.key,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: ListifyTheme.darkMode()
            ? ListifyColors.spaceCadet
            : ListifyColors.white,
        scaffoldBackgroundColor: ListifyTheme.darkMode()
            ? ListifyColors.spaceCadet
            : ListifyColors.white,
        brightness:
            ListifyTheme.darkMode() ? Brightness.dark : Brightness.light,
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
      ),
      home: SplashScreen(),
    );
  }
}
