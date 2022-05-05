import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/utils/navigation.dart';
import 'package:listify/core/base/base_view.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/utils/utils.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controller/authentication/authentication_provider.dart';
import '../auth/sign_up_screen.dart';

class WelcomeScreen extends BaseView {
  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends BaseViewState<WelcomeScreen> {
  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: ListifySize.height(288)),
        Container(
          width: ListifySize.width(439),
          child: Text(
            "Start Using Listify App Today!",
            textAlign: TextAlign.center,
            style: ListifyTextStyle.headLine3,
          ),
        ),
        SizedBox(height: ListifySize.height(61)),
        KFilledButton(
          buttonText: 'Create Account',
          onPressed: () => SignupScreen().push(context),
        ),
        SizedBox(height: ListifySize.height(106)),
        Text(
          "Or",
          textAlign: TextAlign.center,
          style: ListifyTextStyle.bodyText1(),
        ),
        SizedBox(height: ListifySize.height(87)),
        KOutlinedButton.iconText(
          buttonText: 'Sign up with Google',
          assetIcon: ListifyAssets.google,
          onPressed: () =>
              ref.read(firebaseAuthProvider.notifier).signInWithGoogle(),
        ),
        SizedBox(height: ListifySize.height(37)),
        KOutlinedButton.iconText(
          buttonText: 'Sign up with Facebook',
          assetIcon: ListifyAssets.facebook,
          onPressed: () => snackBar(context,
              title: "Feature is not available yet",
              backgroundColor: ListifyColors.charcoal),
        ),
        SizedBox(height: ListifySize.height(308)),
        Text(
          "Already have an account?",
          textAlign: TextAlign.center,
          style: ListifyTextStyle.bodyText3(),
        ),
        SizedBox(height: ListifySize.height(6)),
        KTextButton(
            buttonText: "Login",
            onPressed: () {
              LoginScreen().push(context);
            })
      ],
    );
  }
}
