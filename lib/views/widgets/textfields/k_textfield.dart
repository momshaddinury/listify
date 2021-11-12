import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:listify/views/styles/k_theme.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:intl/intl.dart';

class KTextField extends StatefulWidget {
  KTextField({
    this.hintText,
    this.controller,
    this.multiline = false,
    this.isPasswordField = false,
    this.isCalanderField = false,
    this.isDropdownField = false,
  });

  final String hintText;
  final TextEditingController controller;
  final bool multiline;
  final bool isPasswordField;
  final bool isCalanderField;
  final bool isDropdownField;

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: KSize.getHeight(context, 84),
      width: KSize.getWidth(context, 602),
      color: KTheme.darkMode() ? KColors.darkAccent : KColors.accent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 26)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextFormField(
                onTap: () {
                  if (widget.isCalanderField) {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1900),
                      maxTime: DateTime(2100),
                      onConfirm: (date) {
                        widget.controller.text = DateFormat('hh:mm aa MMM dd, yyyy').format(date);
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  }
                },
                maxLines: widget.multiline ? null : 1,
                minLines: widget.multiline ? 5 : 1,
                obscureText: widget.isPasswordField ? !isVisible : false,
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: KTextStyle.bodyText1(),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (widget.isPasswordField)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Image.asset(
                  isVisible ? KAssets.visibilityOn : KAssets.visibilityOff,
                  height: KSize.getHeight(context, 25),
                  width: KSize.getWidth(context, 25),
                ),
              ),
            if (widget.isCalanderField)
              Image.asset(
                KAssets.calendar,
                height: KSize.getHeight(context, 25),
                width: KSize.getWidth(context, 25),
              ),
            if (widget.isDropdownField)
              Image.asset(
                KAssets.dropdown,
                height: KSize.getHeight(context, 25),
                width: KSize.getWidth(context, 25),
              )
          ],
        ),
      ),
    );
  }
}
