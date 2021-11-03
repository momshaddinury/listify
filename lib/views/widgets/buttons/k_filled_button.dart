import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';

class KFilledButton extends StatelessWidget {
  final buttonText;
  final onPressed;
  final Color buttonColor;
  KFilledButton({
    @required this.buttonText,
    @required this.onPressed,
    this.buttonColor = KColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: KSize.getHeight(context, 84),
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
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
