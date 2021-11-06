import 'package:flutter/material.dart';
import 'package:listify/views/styles/k_theme.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:menu_button/menu_button.dart';

// ignore: must_be_immutable
class KDropdownField extends StatefulWidget {
  final String hintText;
  final List<String> dropdownFieldOptions;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final Function callbackFunction;
  final bool isCallback;

  KDropdownField({
    Key key,
    this.hintText,
    this.dropdownFieldOptions,
    this.controller,
    this.validator,
    this.callbackFunction,
    this.isCallback = false,
  });

  @override
  _KDropdownFieldState createState() => _KDropdownFieldState();
}

class _KDropdownFieldState extends State<KDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MenuButton<String>(
          items: widget.dropdownFieldOptions,
          decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
          itemBuilder: (String value) => Container(
            height: KSize.getHeight(context, 84),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 26)),
            child: Text(
              value,
              style: KTextStyle.bodyText1(),
            ),
          ),
          child: Container(
            color: KTheme.darkMode() ? KColors.darkAccent : KColors.accent,
            height: KSize.getHeight(context, 84),
            width: KSize.getWidth(context, 602),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 26)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      widget.controller.text,
                      style: KTextStyle.bodyText1(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Image.asset(
                    KAssets.dropdown,
                    height: KSize.getHeight(context, 25),
                    width: KSize.getWidth(context, 25),
                  ),
                ],
              ),
            ),
          ),
          onItemSelected: (String value) {
            setState(() {
              widget.controller.text = value;
            });
          },
        )
      ],
    );
  }
}
