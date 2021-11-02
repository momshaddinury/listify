import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:listify/views/styles/k_theme.dart';
import 'package:listify/views/styles/styles.dart';

// ignore: must_be_immutable
class KDropdownField extends StatefulWidget {
  final String title;
  final String hintText;
  final List dropdownFieldOptions;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final Function callbackFunction;
  final bool isCallback;
  final bool isObject;
  final TextEditingController selectedIdController;

  KDropdownField({
    Key key,
    this.title,
    this.hintText,
    this.dropdownFieldOptions,
    this.controller,
    this.validator,
    this.callbackFunction,
    this.isCallback = false,
    this.isObject = true,
    this.selectedIdController,
  });

  @override
  _KDropdownFieldState createState() => _KDropdownFieldState();
}

class _KDropdownFieldState extends State<KDropdownField> {
  @override
  void initState() {
    if (widget.isObject) {
      widget.controller.text = widget.dropdownFieldOptions[0].name;
      widget.selectedIdController.text = widget.dropdownFieldOptions[0].id.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          widget.title != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.start,
                    style: KTextStyle.subtitle2,
                  ))
              : Container(),
          Container(
            height: KSize.getHeight(context, 84),
            width: KSize.getWidth(context, 602),
            color: KTheme.darkMode() ? KColors.darkAccent : KColors.accent,
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 13)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                hint: Text(widget.hintText),
                value: widget.controller.text,
                // boxTextstyle: KTextStyle.bodyText1().copyWith(color: KTheme.darkMode() ? KColors.white : KColors.charcoal),
                // itemTextstyle: KTextStyle.bodyText1(),
                // boxHeight: KSize.getHeight(context, 84),
                // boxWidth: KSize.getWidth(context, 602),
                // itemWidth: KSize.getWidth(context, 602),
                // boxPadding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 13)),
                icon: Icon(Icons.keyboard_arrow_down, size: 25, color: KColors.spaceCadet),
                items: widget.isObject
                    ? widget.dropdownFieldOptions.map((dynamic dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            value: dropDownStringItem.name,
                            child: Text(
                              dropDownStringItem.name,
                              textAlign: TextAlign.left,
                              style: KTextStyle.bodyText2(),
                            ));
                      }).toList()
                    : widget.dropdownFieldOptions.map((dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              textAlign: TextAlign.left,
                              style: KTextStyle.bodyText1().copyWith(color: KColors.charcoal),
                            ));
                      }).toList(),
                onChanged: (String value) {
                  setState(() {
                    widget.controller.text = value;
                    if (widget.isObject) {
                      widget.selectedIdController.text = widget.dropdownFieldOptions[widget.dropdownFieldOptions.indexWhere((element) => element.name == value)].id.toString();
                    }
                  });
                  if (widget.isCallback) widget.callbackFunction();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
