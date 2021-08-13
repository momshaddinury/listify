import 'package:flutter/material.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/buttons/k_outlined_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: KSize.getWidth(context, 59),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: KSize.getHeight(context, 369)),
            Container(
              height: KSize.getHeight(context, 126),
              width: KSize.getWidth(context, 439),
              child: Text(
                "Start Using the ToDo List App Today!",
                textAlign: TextAlign.center,
                style: KTextStyle.headLine3,
              ),
            ),
            SizedBox(height: KSize.getHeight(context, 61)),
            KFilledButton(
              buttonText: 'Create Account',
            ),
            SizedBox(height: KSize.getHeight(context, 106)),
            Text(
              "Or",
              textAlign: TextAlign.center,
              style: KTextStyle.bodyText1(),
            ),
            SizedBox(height: KSize.getHeight(context, 87)),
            KOutlinedButton(
              buttonText: 'Sign up with Google',
              assetIcon: KAssets.google,
            ),
            SizedBox(height: KSize.getHeight(context, 37)),
            KOutlinedButton(
              buttonText: 'Sign up with Facebook',
              assetIcon: KAssets.facebook,
            ),
            SizedBox(height: KSize.getHeight(context, 308)),
            Text(
              "Already have an account?",
              textAlign: TextAlign.center,
              style: KTextStyle.bodyText3(),
            ),
            SizedBox(height: KSize.getHeight(context, 6)),
            InkWell(
              onTap: () {
                Navigator.push(
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
    );
  }
}
