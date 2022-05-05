import 'package:flutter/material.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
import 'package:listify/controller/authentication/authentication_state.dart';
import 'package:listify/utils/navigation.dart';
import 'package:listify/core/base/base_view.dart';
import 'package:listify/views/screens/auth/sign_up_screen.dart';
import 'package:listify/utils/utils.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:listify/views/widgets/k_textfield.dart';
import 'package:nb_utils/nb_utils.dart';

import '../home_screen.dart';

class LoginScreen extends BaseView {
  @override
  BaseViewState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseViewState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void buildMethod() {
    ref.listen(firebaseAuthProvider, (_, state) {
      if (state is FirebaseAuthSuccessState) {
        HomeScreen().pushAndRemoveUntil(context);
      } else if (state is FirebaseAuthErrorState) {
        snackBar(context,
            title: state.message, backgroundColor: ListifyColors.charcoal);
      }
    });
  }

  @override
  Widget body() {
    final authState = ref.watch(firebaseAuthProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: ListifySize.height(332)),
        Container(
          width: ListifySize.width(315),
          child: Text(
            "Welcome Back",
            textAlign: TextAlign.center,
            style: ListifyTextStyle.headLine3,
          ),
        ),
        SizedBox(height: ListifySize.height(63)),
        KTextFormField(
          hintText: 'Your email address',
          controller: emailController,
        ),
        SizedBox(height: ListifySize.height(37)),
        KTextFormField(
          hintText: 'Password',
          controller: passwordController,
          isPasswordField: true,
        ),
        SizedBox(height: ListifySize.height(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Forgot your password?',
              style: ListifyTextStyle.bodyText2()
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(height: ListifySize.height(61)),
        KFilledButton(
          buttonText:
              authState is FirebaseAuthLoadingState ? 'Please wait' : 'Login',
          buttonColor: authState is FirebaseAuthLoadingState
              ? ListifyColors.spaceCadet
              : ListifyColors.primary,
          onPressed: () {
            if (!(authState is FirebaseAuthLoadingState)) {
              if (emailController.text.trim().isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                hideKeyboard(context);
                ref.read(firebaseAuthProvider.notifier).signIn(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              } else {
                if (emailController.text.trim().isEmpty) {
                  snackBar(context,
                      title: "Please enter email",
                      backgroundColor: ListifyColors.charcoal);
                } else if (passwordController.text.isEmpty) {
                  snackBar(context,
                      title: "Please enter password",
                      backgroundColor: ListifyColors.charcoal);
                }
              }
            }
          },
        ),
        SizedBox(height: ListifySize.height(66)),
        Text(
          "Or",
          textAlign: TextAlign.center,
          style: ListifyTextStyle.bodyText1(),
        ),
        SizedBox(height: ListifySize.height(72)),
        KOutlinedButton.iconText(
          onPressed: () =>
              ref.read(firebaseAuthProvider.notifier).signInWithGoogle(),
          buttonText: 'Login with Google',
          assetIcon: ListifyAssets.google,
        ),
        SizedBox(height: ListifySize.height(37)),
        KOutlinedButton.iconText(
          buttonText: 'Login with Facebook',
          assetIcon: ListifyAssets.facebook,
          onPressed: () => snackBar(context,
              title: "Feature is not available yet",
              backgroundColor: ListifyColors.charcoal),
        ),
        SizedBox(height: ListifySize.height(131)),
        Text(
          "Don't have an account?",
          textAlign: TextAlign.center,
          style: ListifyTextStyle.bodyText3(),
        ),
        SizedBox(height: ListifySize.height(6)),
        KTextButton(
            buttonText: "Create account",
            onPressed: () {
              SignupScreen().pushReplacement(context);
            })
      ],
    );
  }
}
