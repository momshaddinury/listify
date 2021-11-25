import 'package:flutter/material.dart';
import 'package:listify/views/styles/k_theme.dart';
import 'package:listify/views/styles/styles.dart';

class KOutlinedButton extends StatelessWidget {
  final buttonText;
  final assetIcon;
  KOutlinedButton({@required this.buttonText, this.assetIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: KSize.getHeight(84),
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: KTheme.darkMode() ? KColors.white : KColors.charcoal)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: KSize.getHeight(34), width: KSize.getWidth(34), child: Image.asset(assetIcon)),
              SizedBox(width: KSize.getWidth(22)),
              Text(
                buttonText,
                style: KTextStyle.buttonText(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
