import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/k_base_screen.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controller/authentication/authentication_provider.dart';
import '../auth/sign_up_screen.dart';

class WelcomeScreen extends KBaseScreen {
  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends KBaseState<WelcomeScreen> {
  @override
  Widget body() {
    return Column(
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
          onPressed: () => SignupScreen().push(context),
        ),
        SizedBox(height: KSize.getHeight(106)),
        Text(
          "Or",
          textAlign: TextAlign.center,
          style: KTextStyle.bodyText1(),
        ),
        SizedBox(height: KSize.getHeight(87)),
        KOutlinedButton.iconText(
          buttonText: 'Sign up with Google',
          assetIcon: KAssets.google,
          onPressed: () =>
              ref.read(firebaseAuthProvider.notifier).signInWithGoogle(),
        ),
        SizedBox(height: KSize.getHeight(37)),
        KOutlinedButton.iconText(
          buttonText: 'Sign up with Facebook',
          assetIcon: KAssets.facebook,
          onPressed: () => snackBar(context,
              title: "Feature is not available yet",
              backgroundColor: KColors.charcoal),
        ),
        SizedBox(height: KSize.getHeight(308)),
        Text(
          "Already have an account?",
          textAlign: TextAlign.center,
          style: KTextStyle.bodyText3(),
        ),
        SizedBox(height: KSize.getHeight(6)),
        KTextButton(
            buttonText: "Login",
            onPressed: () {
              LoginScreen().push(context);
            })
      ],
    );
  }
}
