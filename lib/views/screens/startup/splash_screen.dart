import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/auth/auth_wrapper.dart';
import 'package:listify/views/styles/k_assets.dart';
import 'package:listify/views/styles/k_colors.dart';
import 'package:listify/views/styles/k_size.dart';
import 'package:listify/views/styles/k_text_style.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
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
        ref.read(firebaseProvider).signOut();
      }
      AuthenticationWrapper().pushAndRemoveUntil(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
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
                  height: KSize.getHeight(20),
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
