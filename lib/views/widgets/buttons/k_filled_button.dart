import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';

class KFilledButton extends StatelessWidget {
  final buttonText;
  final onPressed;
  KFilledButton({@required this.buttonText, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: KSize.getHeight(context, 84),
        width: double.infinity,
        decoration: BoxDecoration(
          color: KColors.primary,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: KTextStyle.buttonText().copyWith(color: KColors.white),
          ),
        ),
      ),
    );
  }
}
