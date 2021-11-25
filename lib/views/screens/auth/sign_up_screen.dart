import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:listify/controller/authentication/authentication_controller.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/snack_bar.dart';
import 'package:listify/views/widgets/textfields/k_textfield.dart';
import 'package:nb_utils/nb_utils.dart';

class SignupScreen extends ConsumerStatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: KSize.getHeight(context, 288)),
              Container(
                width: KSize.getWidth(context, 439),
                child: Text(
                  "Not your everyday Todo app!",
                  textAlign: TextAlign.center,
                  style: KTextStyle.headLine3,
                ),
              ),
              SizedBox(height: KSize.getHeight(context, 44)),
              KTextField(
                hintText: 'Email Address',
                controller: emailController,
              ),
              SizedBox(height: KSize.getHeight(context, 37)),
              KTextField(
                hintText: 'Password',
                controller: passwordController,
                isPasswordField: true,
              ),
              SizedBox(height: KSize.getHeight(context, 37)),
              KTextField(
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
                isPasswordField: true,
              ),
              SizedBox(height: KSize.getHeight(context, 106)),
              GetBuilder<AuthenticationController>(
                builder: (_) {
                  return KFilledButton(
                    buttonText: authenticationController.isLoading ? 'Please wait' : 'Create Account',
                    buttonColor: authenticationController.isLoading ? KColors.spaceCadet : KColors.primary,
                    onPressed: () {
                      hideKeyboard(context);
                      if (emailController.text.trim().isNotEmpty) {
                        if (passwordController.text == confirmPasswordController.text) {
                          authenticationController.signUp(email: emailController.text, password: passwordController.text);
                        } else {
                          kSnackBar('Warning', "Password doesn't match");
                        }
                      } else {
                        kSnackBar('Warning', "Please enter email");
                      }
                    },
                  );
                },
              ),
              SizedBox(height: KSize.getHeight(context, 110)),
              Text(
                "Already have an account?",
                textAlign: TextAlign.center,
                style: KTextStyle.bodyText3(),
              ),
              SizedBox(height: KSize.getHeight(context, 6)),
              InkWell(
                onTap: () {
                  Get.off(() => LoginScreen());
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
      ),
    );
  }
}
