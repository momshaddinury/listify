import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
import 'package:listify/controller/authentication/authentication_state.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/auth/sign_up_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:listify/views/widgets/k_textfield.dart';
import 'package:nb_utils/nb_utils.dart';

import '../home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(firebaseAuthProvider, (_, state) {
      if (state is FirebaseAuthSuccessState) {
        HomeScreen().pushAndRemoveUntil(context);
      } else if (state is FirebaseAuthErrorState) {
        snackBar(context, title: state.message, backgroundColor: KColors.charcoal);
      }
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: KSize.getHeight(332)),
              Container(
                width: KSize.getWidth(315),
                child: Text(
                  "Welcome Back",
                  textAlign: TextAlign.center,
                  style: KTextStyle.headLine3,
                ),
              ),
              SizedBox(height: KSize.getHeight(63)),
              KTextFormField(
                hintText: 'Your email address',
                controller: emailController,
              ),
              SizedBox(height: KSize.getHeight(37)),
              KTextFormField(
                hintText: 'Password',
                controller: passwordController,
                isPasswordField: true,
              ),
              SizedBox(height: KSize.getHeight(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot your password?',
                    style: KTextStyle.bodyText2().copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(height: KSize.getHeight(61)),
              Consumer(builder: (context, WidgetRef ref, _) {
                final authState = ref.watch(firebaseAuthProvider);
                return KFilledButton(
                  buttonText: authState is FirebaseAuthLoadingState ? 'Please wait' : 'Login',
                  buttonColor: authState is FirebaseAuthLoadingState ? KColors.spaceCadet : KColors.primary,
                  onPressed: () {
                    if (!(authState is FirebaseAuthLoadingState)) {
                      if (emailController.text.trim().isNotEmpty && passwordController.text.isNotEmpty) {
                        hideKeyboard(context);
                        ref.read(firebaseAuthProvider.notifier).signIn(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                      } else {
                        if (emailController.text.trim().isEmpty) {
                          snackBar(context, title: "Please enter email", backgroundColor: KColors.charcoal);
                        } else if (passwordController.text.isEmpty) {
                          snackBar(context, title: "Please enter password", backgroundColor: KColors.charcoal);
                        }
                      }
                    }
                  },
                );
              }),
              SizedBox(height: KSize.getHeight(66)),
              Text(
                "Or",
                textAlign: TextAlign.center,
                style: KTextStyle.bodyText1(),
              ),
              SizedBox(height: KSize.getHeight(72)),
              KOutlinedButton.iconText(
                buttonText: 'Login with Google',
                assetIcon: KAssets.google,
              ),
              SizedBox(height: KSize.getHeight(37)),
              KOutlinedButton.iconText(
                buttonText: 'Login with Facebook',
                assetIcon: KAssets.facebook,
              ),
              SizedBox(height: KSize.getHeight(131)),
              Text(
                "Don't have an account?",
                textAlign: TextAlign.center,
                style: KTextStyle.bodyText3(),
              ),
              SizedBox(height: KSize.getHeight(6)),
              KTextButton(
                  buttonText: "Create account",
                  onPressed: () {
                    SignupScreen().pushReplacement(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
