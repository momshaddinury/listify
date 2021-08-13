import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';

class KFilledButton extends StatelessWidget {
  final buttonText;

  KFilledButton({@required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
