import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
import 'package:listify/controller/authentication/authentication_state.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/screens/home_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:listify/views/widgets/k_textfield.dart';
import 'package:nb_utils/nb_utils.dart';

class SignupScreen extends ConsumerStatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  // final TextEditingController sexFieldController = TextEditingController(text: 'Select');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(
      firebaseAuthProvider,
      (_, state) {
        if (state is FirebaseAuthSuccessState) {
          HomeScreen().pushAndRemoveUntil(context);
        } else if (state is FirebaseAuthErrorState) {
          snackBar(context, title: state.message, backgroundColor: KColors.charcoal);
        }
      },
    );
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
              // KTextField(
              //   hintText: 'Name',
              // ),
              // SizedBox(height: KSize.getHeight(37)),
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

              // SizedBox(height: KSize.getHeight(37)),
              /* KDropdownField(
                  hintText: 'Sex',
                  controller: sexFieldController,
                  dropdownFieldOptions: ['Select', 'Male', 'Female'],
                  isObject: false,
                ), */
              /* SizedBox(height: KSize.getHeight(25)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: KSize.getWidth(14)),
                      child: Image.asset(
                        KAssets.syncCheck,
                        height: KSize.getHeight(18),
                        width: KSize.getWidth(19),
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
              SizedBox(height: KSize.getHeight(106)),
              Consumer(builder: (context, WidgetRef ref, _) {
                final authState = ref.watch(firebaseAuthProvider);
                return KFilledButton(
                  buttonText: authState is FirebaseAuthLoadingState ? 'Please wait' : 'Create Account',
                  buttonColor: authState is FirebaseAuthLoadingState ? KColors.spaceCadet : KColors.primary,
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
                          snackBar(context, title: "Password doesn't match", backgroundColor: KColors.charcoal);
                        }
                      }
                    }
                  },
                );
              }),
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
          ),
        ),
      ),
    );
  }
}
