import 'package:flutter/material.dart';
import 'package:listify/view_model/authentication_view_model.dart';
import 'package:listify/views/styles/k_assets.dart';
import 'package:listify/views/styles/k_colors.dart';
import 'package:listify/views/styles/k_size.dart';
import 'package:listify/views/styles/k_textstyle.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(AuthenticationViewModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: KSize.getWidth(59),
            vertical: KSize.getWidth(59),
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
