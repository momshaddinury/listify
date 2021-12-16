import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/custom_widget/dropdown_menu.dart';

class KDropdownField extends DropdownMenus {
  KDropdownField({
    Key key,
    this.dropdownFieldOptions,
    this.controller,
    this.callbackFunction,
  })  : assert(controller != null),
        assert(dropdownFieldOptions.length > 1, 'Must have more than 1 item'),
        super(
          key: key,
          controller: controller,
          items: dropdownFieldOptions,
          onChange: callbackFunction,
          hintTextStyle: KTextStyle.bodyText1().copyWith(color: KColors.charcoal),
          itemTextStyle: KTextStyle.bodyText1().copyWith(color: KColors.charcoal),
          menuBackgroundColor: KColors.accent,
          itemBackgroundColor: KColors.accent,
        );

  final List<String> dropdownFieldOptions;
  final TextEditingController controller;
  final Function callbackFunction;
}
