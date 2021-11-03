import 'package:flutter/material.dart';
import 'package:listify/views/styles/k_theme.dart';
import 'package:listify/views/styles/styles.dart';

class KTextField extends StatelessWidget {
  KTextField({
    this.hintText,
    this.controller,
    this.isPasswordField = false,
    this.isCalanderField = false,
    this.isDropdownField = false,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPasswordField;
  final bool isCalanderField;
  final bool isDropdownField;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: KSize.getHeight(context, 84),
      width: KSize.getWidth(context, 602),
      color: KTheme.darkMode() ? KColors.darkAccent : KColors.accent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 26)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: KTextStyle.bodyText1(),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (isPasswordField)
              Image.asset(
                KAssets.visibilityOff,
                height: KSize.getHeight(context, 25),
                width: KSize.getWidth(context, 25),
              ),
            if (isCalanderField)
              Image.asset(
                KAssets.calendar,
                height: KSize.getHeight(context, 25),
                width: KSize.getWidth(context, 25),
              ),
            if (isDropdownField)
              Image.asset(
                KAssets.dropdown,
                height: KSize.getHeight(context, 25),
                width: KSize.getWidth(context, 25),
              )
          ],
        ),
      ),
    );
  }
}
