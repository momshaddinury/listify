import 'package:flutter/material.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
// import 'package:listify/views/widgets/textfields/k_dropdown_textfield.dart';
import 'package:listify/views/widgets/textfields/k_textfield.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController sexFieldController = TextEditingController(text: 'Select');

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
                height: KSize.getHeight(context, 126),
                width: KSize.getWidth(context, 439),
                child: Text(
                  "Start Using the ToDo List App Today!",
                  textAlign: TextAlign.center,
                  style: KTextStyle.headLine3,
                ),
              ),
              SizedBox(height: KSize.getHeight(context, 44)),
              KTextField(
                hintText: 'Name',
              ),
              SizedBox(height: KSize.getHeight(context, 37)),
              KTextField(
                hintText: 'Email Address',
              ),
              SizedBox(height: KSize.getHeight(context, 37)),
              KTextField(
                hintText: 'Password',
                isPasswordField: true,
              ),
              SizedBox(height: KSize.getHeight(context, 37)),
              KTextField(
                hintText: 'Confirm Password',
                isPasswordField: true,
              ),

              // SizedBox(height: KSize.getHeight(context, 37)),
              /* KDropdownField(
                hintText: 'Sex',
                controller: sexFieldController,
                dropdownFieldOptions: ['Select', 'Male', 'Female'],
                isObject: false,
              ), */
              SizedBox(height: KSize.getHeight(context, 25)),
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
              ),
              SizedBox(height: KSize.getHeight(context, 106)),
              KFilledButton(
                buttonText: 'Create Account',
                onPressed: () {},
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
    );
  }
}
