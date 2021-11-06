import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/controller/authentication/authentication_controller.dart';
import 'package:listify/main.dart';
import 'package:listify/views/styles/k_assets.dart';
import 'package:listify/views/styles/k_colors.dart';
import 'package:listify/views/styles/k_size.dart';
import 'package:listify/views/styles/k_textstyle.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    Timer(Duration(milliseconds: 1000), () {
      /// Checking if app is Newly Installed / User is logged in / User is not logged in
      if (getBoolAsync(NEW_INSTALL, defaultValue: true)) {
        setValue(NEW_INSTALL, false);
        context.read(firebaseProvider).signOut();
      }
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthenticationWrapper()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: KSize.getWidth(context, 59),
            vertical: KSize.getWidth(context, 59),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Listify",
                  style: KTextStyle.headLine3,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: KSize.getHeight(context, 20),
                ),
                Text(
                  "Not your every day todo app",
                  style: KTextStyle.subtitle1,
                ),
                Image.asset(
                  KAssets.appLogo,
                  width: MediaQuery.of(context).size.width * .30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
