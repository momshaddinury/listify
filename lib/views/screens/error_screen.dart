import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/k_base_screen.dart';
import 'package:listify/views/styles/k_colors.dart';
import 'package:listify/views/styles/k_text_style.dart';
import 'package:listify/views/widgets/k_app_bar.dart';

class ErrorScreen extends KBaseScreen {
  @override
  KBaseState<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends KBaseState<ErrorScreen> {
  @override
  Widget appBar() {
    return KAppBar(
      titleText: "Error",
      onTap: () =>
          Navigator.of(context).canPop() ? Navigation.pop(context) : null,
    );
  }
  @override
  bool defaultPadding() => false;

  @override
  bool scrollable() => false;

  @override
  Widget body() {
    return KErrorWidget();
  }
}

class KErrorWidget extends StatelessWidget {
  const KErrorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "OOPS",
            style: KTextStyle.headLine2.copyWith(
              color: Color(0xFFE5F3F1),
              letterSpacing: 29.5,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Something Went Wrong",
            style: KTextStyle.headLine3.copyWith(
              color: KColors.charcoal,
            ),
          ),
          SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  """Sorry, we can’t process your request at the moment. Please try again after sometime. Few things to check: Internet connection, Try restarting the app, Check for update. If nothing works please report a bug""",
              style: KTextStyle.bodyText1().copyWith(
                color: KColors.charcoal,
              ),
              children: [
                TextSpan(
                    text: " here.",
                    style: KTextStyle.bodyText1().copyWith(
                      color: KColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ///TODO: Open email using default email app
                      })
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
