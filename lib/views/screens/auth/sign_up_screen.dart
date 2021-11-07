import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_controller.dart';
import 'package:listify/controller/authentication/authentication_state.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/screens/home_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/textfields/k_textfield.dart';
import 'package:nb_utils/nb_utils.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // final TextEditingController sexFieldController = TextEditingController(text: 'Select');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
        } else if (state is FirebaseAuthErrorState) {
          snackBar(context,
              title: state.message, backgroundColor: KColors.charcoal);
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
                // KTextField(
                //   hintText: 'Name',
                // ),
                // SizedBox(height: KSize.getHeight(context, 37)),
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

                // SizedBox(height: KSize.getHeight(context, 37)),
                /* KDropdownField(
                  hintText: 'Sex',
                  controller: sexFieldController,
                  dropdownFieldOptions: ['Select', 'Male', 'Female'],
                  isObject: false,
                ), */
                /* SizedBox(height: KSize.getHeight(context, 25)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: KSize.getWidth(context, 14)),
                      child: Image.asset(
                        KAssets.syncCheck,
                        height: KSize.getHeight(context, 18),
                        width: KSize.getWidth(context, 19),
                      ),
                    ),
                    Text(
                      'Sync with email',
                      style: KTextStyle.bodyText2().copyWith(
                        fontWeight: FontWeight.w100,
                        color: KColors.primary,
                      ),
                    ),
                  ],
                ), */
                SizedBox(height: KSize.getHeight(context, 106)),
                Consumer(builder: (context, watch, _) {
                  final authState = watch(firebaseAuthProvider.state);
                  return KFilledButton(
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
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            context.read(firebaseAuthProvider).signUp(
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
                  );
                }),
                SizedBox(height: KSize.getHeight(context, 110)),
                Text(
                  "Already have an account?",
                  textAlign: TextAlign.center,
                  style: KTextStyle.bodyText3(),
                ),
                SizedBox(height: KSize.getHeight(context, 6)),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
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
      ),
    );
  }
}
