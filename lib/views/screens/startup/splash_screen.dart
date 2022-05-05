import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/auth/auth_wrapper.dart';
import 'package:listify/core/base/base_view.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends BaseView {
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseViewState<SplashScreen> {
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
  bool scrollable() => false;

  @override
  Widget body() {
    return Center(
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
    );
  }
}
