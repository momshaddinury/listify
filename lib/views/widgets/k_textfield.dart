import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:intl/intl.dart';

class KTextField extends StatefulWidget {
  KTextField({
    this.hintText,
    this.controller,
    this.multiline = false,
    this.minimumLines = 1,
    this.isPasswordField = false,
    this.isCalenderField = false,
    this.isDropdownField = false,
  });

  final String hintText;
  final TextEditingController controller;
  final bool multiline;
  final int minimumLines;
  final bool isPasswordField;
  final bool isCalenderField;
  final bool isDropdownField;

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: KSize.getHeight(84),
      width: KSize.getWidth(602),
      color: KTheme.darkMode() ? KColors.darkAccent : KColors.accent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(26)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextFormField(
                onTap: () {
                  if (widget.isCalenderField) {
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
                minLines: widget.multiline ? widget.minimumLines : 1,
                obscureText: widget.isPasswordField ? !isVisible : false,
                controller: widget.controller,
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: KTextStyle.bodyText1().copyWith(color: KColors.charcoal),
                    border: InputBorder.none,
                    suffixIcon: widget.isPasswordField
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: Image.asset(
                              isVisible ? KAssets.visibilityOn : KAssets.visibilityOff,
                            ),
                          )
                        : null,
                    suffixIconConstraints: BoxConstraints(
                      maxHeight: KSize.getHeight(25),
                      minWidth: KSize.getWidth(25),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
