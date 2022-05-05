import 'package:flutter/material.dart';
import 'package:listify/utils/utils.dart';
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
          hintTextStyle: ListifyTextStyle.bodyText1()
              .copyWith(color: ListifyColors.charcoal),
          itemTextStyle: ListifyTextStyle.bodyText1()
              .copyWith(color: ListifyColors.charcoal),
          menuBackgroundColor: ListifyColors.accent,
          itemBackgroundColor: ListifyColors.accent,
        );

  final List<String> dropdownFieldOptions;
  final TextEditingController controller;
  final Function callbackFunction;
}
