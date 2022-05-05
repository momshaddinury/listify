import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listify/utils/navigation.dart';
import 'package:listify/core/base/base_view.dart';
import 'package:listify/utils/colors.dart';
import 'package:listify/utils/text_style.dart';
import 'package:listify/views/widgets/k_app_bar.dart';

class ErrorScreen extends BaseView {
  @override
  BaseViewState<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends BaseViewState<ErrorScreen> {
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
            style: ListifyTextStyle.headLine2.copyWith(
              color: Color(0xFFE5F3F1),
              letterSpacing: 29.5,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Something Went Wrong",
            style: ListifyTextStyle.headLine3.copyWith(
              color: ListifyColors.charcoal,
            ),
          ),
          SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  """Sorry, we can’t process your request at the moment. Please try again after sometime. Few things to check: Internet connection, Try restarting the app, Check for update. If nothing works please report a bug""",
              style: ListifyTextStyle.bodyText1().copyWith(
                color: ListifyColors.charcoal,
              ),
              children: [
                TextSpan(
                    text: " here.",
                    style: ListifyTextStyle.bodyText1().copyWith(
                      color: ListifyColors.primary,
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
