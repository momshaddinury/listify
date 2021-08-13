import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';

class KTextField extends StatelessWidget {
  KTextField({
    this.hintText,
    this.isPasswordField = false,
  });

  final String? hintText;
  final bool isPasswordField;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: KSize.getHeight(context, 84),
      width: KSize.getWidth(context, 602),
      color: KColors.accent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: KTextStyle.bodyText1(),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: KSize.getWidth(context, 26),
                  )),
            ),
          ),
          if (isPasswordField)
            Padding(
              padding: EdgeInsets.only(right: KSize.getWidth(context, 32)),
              child: Image.asset(
                KAssets.visibilityOff,
                height: KSize.getHeight(context, 25),
                width: KSize.getWidth(context, 25),
              ),
            )
        ],
      ),
    );
  }
}
