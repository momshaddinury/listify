import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';

class KDropdownField extends StatefulWidget {
  KDropdownField({
    Key key,
    this.dropdownFieldOptions,
    this.controller,
    this.callbackFunction,
  })  : assert(controller != null),
        assert(dropdownFieldOptions.length > 1, 'Must have more than 1 item'),
        super(key: key);

  final List<String> dropdownFieldOptions;
  final TextEditingController controller;
  final Function callbackFunction;

  @override
  State<KDropdownField> createState() => _KDropdownFieldState();
}

class _KDropdownFieldState extends State<KDropdownField> {
  GlobalKey _key = LabeledGlobalKey('customDropdownField');

  OverlayEntry _overlayEntry;

  Size dropDownFieldSize;

  Offset dropDownFieldPosition;

  double spaceBetweenFieldAndOptions = 5;
  double spaceBetweenOptions = 5;

  bool isDropDownOpen = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller.text == null || widget.controller.text == "") widget.controller.text = 'Select an option';
  }

  void findWidget() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    dropDownFieldSize = renderBox.size;
    dropDownFieldPosition = renderBox.localToGlobal(Offset.zero);
  }

  void openDropDownMenu() {
    findWidget();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isDropDownOpen = !isDropDownOpen;
  }

  void closeDropDownMenu() {
    _overlayEntry.remove();
    isDropDownOpen = !isDropDownOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      color: KColors.accent,
      padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(26), vertical: 12),
      child: InkWell(
        onTap: () {
          if (isDropDownOpen) {
            closeDropDownMenu();
          } else {
            openDropDownMenu();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.controller.text,
              style: KTextStyle.bodyText1().copyWith(color: KColors.charcoal),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _dropDownMenuBuilder(List<String> item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: item.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    widget.controller.text = item[index];
                  });
                  closeDropDownMenu();
                },
                child: Container(
                  width: dropDownFieldSize.width,
                  padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(26), vertical: 12),
                  decoration: BoxDecoration(color: KColors.accent),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                          child: Text(
                        item[index],
                        style: KTextStyle.bodyText1().copyWith(color: KColors.charcoal),
                      )),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(builder: (context) {
      return Positioned(
          top: dropDownFieldPosition.dy + dropDownFieldSize.height + spaceBetweenFieldAndOptions,
          left: dropDownFieldPosition.dx,
          width: dropDownFieldSize.width,
          child: Material(child: _dropDownMenuBuilder(widget.dropdownFieldOptions)));
    });
  }
}
