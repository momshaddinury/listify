import 'package:flutter/material.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
import 'package:listify/controller/authentication/authentication_state.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/k_base_screen.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/screens/home_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:listify/views/widgets/k_textfield.dart';
import 'package:nb_utils/nb_utils.dart';

class SignupScreen extends KBaseScreen {
  SignupScreen({Key key}) : super(key: key);

  @override
  KBaseState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends KBaseState<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void buildMethod() {
    ref.listen(
      firebaseAuthProvider,
      (_, state) {
        if (state is FirebaseAuthSuccessState) {
          HomeScreen().pushAndRemoveUntil(context);
        } else if (state is FirebaseAuthErrorState) {
          snackBar(context,
              title: state.message, backgroundColor: KColors.charcoal);
        }
      },
    );
    super.buildMethod();
  }

  @override
  Widget body() {
    final authState = ref.watch(firebaseAuthProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: KSize.getHeight(288)),
        Container(
          width: KSize.getWidth(439),
          child: Text(
            "Not your everyday Todo app!",
            textAlign: TextAlign.center,
            style: KTextStyle.headLine3,
          ),
        ),
        SizedBox(height: KSize.getHeight(44)),
        KTextFormField(
          hintText: 'Email Address',
          controller: emailController,
        ),
        SizedBox(height: KSize.getHeight(37)),
        KTextFormField(
          hintText: 'Password',
          controller: passwordController,
          isPasswordField: true,
        ),
        SizedBox(height: KSize.getHeight(37)),
        KTextFormField(
          hintText: 'Confirm Password',
          controller: confirmPasswordController,
          isPasswordField: true,
        ),
        SizedBox(height: KSize.getHeight(106)),
        KFilledButton(
          buttonText: authState is FirebaseAuthLoadingState
              ? 'Please wait'
              : 'Create Account',
          buttonColor: authState is FirebaseAuthLoadingState
              ? KColors.spaceCadet
              : KColors.primary,
          onPressed: () {
            if (!(authState is FirebaseAuthLoadingState)) {
              hideKeyboard(context);
              if (emailController.text.trim().isNotEmpty) {
                if (passwordController.text == confirmPasswordController.text) {
                  ref.read(firebaseAuthProvider.notifier).signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                } else {
                  snackBar(context,
                      title: "Password doesn't match",
                      backgroundColor: KColors.charcoal);
                }
              }
            }
          },
        ),
        SizedBox(height: KSize.getHeight(110)),
        Text(
          "Already have an account?",
          textAlign: TextAlign.center,
          style: KTextStyle.bodyText3(),
        ),
        SizedBox(height: KSize.getHeight(6)),
        KTextButton(
            buttonText: "Login",
            onPressed: () {
              LoginScreen().pushReplacement(context);
            })
      ],
    );
  }
}
