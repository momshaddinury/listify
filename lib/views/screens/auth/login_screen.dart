import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:listify/view_model/authentication_view_model.dart';
import 'package:listify/views/screens/auth/sign_up_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/buttons/k_outlined_button.dart';
import 'package:listify/views/widgets/snack_bar.dart';
import 'package:listify/views/widgets/textfields/k_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authVM = Get.put(AuthenticationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: KSize.getWidth(59),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: KSize.getHeight(332)),
              Container(
                height: KSize.getHeight(63),
                width: KSize.getWidth(315),
                child: Text(
                  "Welcome Back",
                  textAlign: TextAlign.center,
                  style: KTextStyle.headLine3,
                ),
              ),
              SizedBox(height: KSize.getHeight(63)),
              KTextField(
                hintText: 'Your email address',
                controller: emailController,
              ),
              SizedBox(height: KSize.getHeight(37)),
              KTextField(
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
              GetBuilder<AuthenticationViewModel>(
                builder: (_) {
                  return KFilledButton(
                    buttonText: authVM.isLoading ? 'Please wait' : 'Login',
                    buttonColor: authVM.isLoading ? KColors.spaceCadet : KColors.primary,
                    onPressed: () {
                      if (!(authVM.isLoading)) {
                        if (emailController.text.trim().isNotEmpty && passwordController.text.isNotEmpty) {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          authVM.signIn(email: emailController.text, password: passwordController.text);
                        } else {
                          if (emailController.text.trim().isEmpty) {
                            kSnackBar('Warning', "Please enter email");
                          } else if (passwordController.text.isEmpty) {
                            kSnackBar('Warning', "Please enter password");
                          }
                        }
                      }
                    },
                  );
                },
              ),
              SizedBox(height: KSize.getHeight(66)),
              Text(
                "Or",
                textAlign: TextAlign.center,
                style: KTextStyle.bodyText1(),
              ),
              SizedBox(height: KSize.getHeight(72)),
              KOutlinedButton(
                buttonText: 'Login with Google',
                assetIcon: KAssets.google,
              ),
              SizedBox(height: KSize.getHeight(37)),
              KOutlinedButton(
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
              InkWell(
                onTap: () => Get.off(() => SignupScreen()),
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
