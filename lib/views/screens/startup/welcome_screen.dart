import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/buttons/k_outlined_button.dart';

import '../auth/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: KSize.getWidth(59),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: KSize.getHeight(288)),
            Container(
              width: KSize.getWidth(439),
              child: Text(
                "Start Using Listify App Today!",
                textAlign: TextAlign.center,
                style: KTextStyle.headLine3,
              ),
            ),
            SizedBox(height: KSize.getHeight(61)),
            KFilledButton(
              buttonText: 'Create Account',
              onPressed: () async => Get.to(() => SignupScreen()),
            ),
            SizedBox(height: KSize.getHeight(106)),
            Text(
              "Or",
              textAlign: TextAlign.center,
              style: KTextStyle.bodyText1(),
            ),
            SizedBox(height: KSize.getHeight(87)),
            KOutlinedButton(
              buttonText: 'Sign up with Google',
              assetIcon: KAssets.google,
            ),
            SizedBox(height: KSize.getHeight(37)),
            KOutlinedButton(
              buttonText: 'Sign up with Facebook',
              assetIcon: KAssets.facebook,
            ),
            SizedBox(height: KSize.getHeight(308)),
            Text(
              "Already have an account?",
              textAlign: TextAlign.center,
              style: KTextStyle.bodyText3(),
            ),
            SizedBox(height: KSize.getHeight(6)),
            InkWell(
              onTap: () {
                Get.to(() => LoginScreen());
              },
              child: Text(
                "Login",
                textAlign: TextAlign.center,
                style: KTextStyle.bodyText2(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
