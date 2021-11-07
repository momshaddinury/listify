import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_controller.dart';
import 'package:listify/controller/authentication/authentication_state.dart';
import 'package:listify/views/screens/auth/sign_up_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/buttons/k_outlined_button.dart';
import 'package:listify/views/widgets/textfields/k_textfield.dart';
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      } else if (state is FirebaseAuthErrorState) {
        snackBar(context, title: state.message, backgroundColor: KColors.charcoal);
      }
    });

    return Scaffold(
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
    );
  }
}
