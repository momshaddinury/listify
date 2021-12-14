import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';

/// Base protected class for all the heavy lifting.
/// All other button class must extend this class.
/// Configuration and changes  should be made as
/// per design need
class _KButton extends StatelessWidget {
  _KButton({
    @required this.child,
    @required this.onPressed,
    this.backgroundColor = KColors.primary,
    this.height = 50,
    this.width = double.infinity,
    this.border,
  })  : assert(child != null),
        assert(onPressed != null);

  final Widget child;
  final Color backgroundColor;
  final double height;
  final double width;
  final VoidCallback onPressed;
  final Border border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
        ),
        child: child,
      ),
    );
  }
}

/// Filled Styled Configuration class for the [_KButton] super class.
/// According to the UI design, all filled style buttons
/// configuration can be set using this widget.
/// There are three primary configuration:
/// 1. Text [KFilledButton]
/// 2. Icon Text [KFilledButton.iconText]
/// 3. Text Icon (Yet to be implemented)
class KFilledButton extends _KButton {
  KFilledButton({
    @required String buttonText,
    @required VoidCallback onPressed,
    Color buttonColor = KColors.primary,
  })  : assert(buttonText != null),
        assert(onPressed != null),
        super(
          child: Center(
            child: Text(
              buttonText,
              style: KTextStyle.buttonText().copyWith(color: KColors.white),
            ),
          ),
          onPressed: onPressed,
          backgroundColor: buttonColor,
          height: KSize.getHeight(84),
        );

  KFilledButton.iconText({
    @required IconData icon,
    @required String buttonText,
    @required VoidCallback onPressed,
    Color buttonColor = KColors.primary,
  })  : assert(icon != null),
        assert(buttonText != null),
        assert(onPressed != null),
        super(
          child: Row(
            children: [
              SizedBox(width: KSize.getWidth(31)),
              Icon(icon, color: KColors.white),
              SizedBox(width: KSize.getWidth(24)),
              Text(
                buttonText,
                style: KTextStyle.bodyText2().copyWith(color: KColors.white),
              )
            ],
          ),
          onPressed: onPressed,
          backgroundColor: buttonColor,
          height: KSize.getHeight(84),
        );
}

/// Outlined Styled Configuration class for the [_KButton] super class.
/// According to the UI design, all outlined style buttons
/// configuration can be set using this widget.
class KOutlinedButton extends _KButton {
  final String buttonText;
  final String assetIcon;

  KOutlinedButton({
    @required this.buttonText,
    this.assetIcon,
  })  : assert(buttonText != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: KSize.getHeight(34),
                width: KSize.getWidth(34),
                child: Image.asset(assetIcon),
              ),
              SizedBox(width: KSize.getWidth(22)),
              Text(
                buttonText,
                style: KTextStyle.buttonText(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          onPressed: () {},
          backgroundColor: KColors.transparent,
          height: KSize.getHeight(84),
          border: Border.all(
            color: KTheme.darkMode() ? KColors.white : KColors.charcoal,
          ),
        );
}
