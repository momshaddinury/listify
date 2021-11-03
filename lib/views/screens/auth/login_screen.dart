import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_controller.dart';
import 'package:listify/controller/authentication/authentication_state.dart';
import 'package:listify/views/screens/auth/sign_up_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/buttons/k_outlined_button.dart';
import 'package:listify/views/widgets/textfields/k_textfield.dart';

import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: firebaseAuthProvider.state,
      onChange: (context, state) {
        if (state is FirebaseAuthSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: KSize.getWidth(context, 59),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: KSize.getHeight(context, 332)),
                Container(
                  height: KSize.getHeight(context, 63),
                  width: KSize.getWidth(context, 315),
                  child: Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: KTextStyle.headLine3,
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 63)),
                KTextField(
                  hintText: 'Your email address',
                  controller: emailController,
                ),
                SizedBox(height: KSize.getHeight(context, 37)),
                KTextField(
                  hintText: 'Password',
                  controller: passwordController,
                  isPasswordField: true,
                ),
                SizedBox(height: KSize.getHeight(context, 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot your password?',
                      style: KTextStyle.bodyText2().copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(height: KSize.getHeight(context, 61)),
                Consumer(builder: (context, watch, _) {
                  final authState = watch(firebaseAuthProvider.state);
                  return KFilledButton(
                    buttonText: authState is FirebaseAuthLoadingState ? 'Please wait' : 'Login',
                    buttonColor: authState is FirebaseAuthLoadingState ? KColors.spaceCadet : KColors.primary,
                    onPressed: () {
                      if (!(authState is FirebaseAuthLoadingState)) {
                        context.read(firebaseAuthProvider).signIn(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                      }
                    },
                  );
                }),
                SizedBox(height: KSize.getHeight(context, 66)),
                Text(
                  "Or",
                  textAlign: TextAlign.center,
                  style: KTextStyle.bodyText1(),
                ),
                SizedBox(height: KSize.getHeight(context, 72)),
                KOutlinedButton(
                  buttonText: 'Login with Google',
                  assetIcon: KAssets.google,
                ),
                SizedBox(height: KSize.getHeight(context, 37)),
                KOutlinedButton(
                  buttonText: 'Login with Facebook',
                  assetIcon: KAssets.facebook,
                ),
                SizedBox(height: KSize.getHeight(context, 131)),
                Text(
                  "Don't have an account?",
                  textAlign: TextAlign.center,
                  style: KTextStyle.bodyText3(),
                ),
                SizedBox(height: KSize.getHeight(context, 6)),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text(
                    "Create account",
                    textAlign: TextAlign.center,
                    style: KTextStyle.bodyText2(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
