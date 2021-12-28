import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';

class KAppBar extends AppBar {
  final String titleText;
  final VoidCallback onTap;
  final Widget trailing;

  KAppBar({
    Key key,
    @required this.titleText,
    @required this.onTap,
    this.trailing,
  }) : super(
          key: key,
          leadingWidth: 0,
          titleSpacing: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ExpandTapWidget(
                  onTap: onTap,
                  tapPadding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    KAssets.backButton,
                    height: KSize.getHeight(32),
                    width: KSize.getWidth(32),
                  ),
                ),
                Text(titleText, style: KTextStyle.headLine4),
                trailing ?? Container()
              ],
            ),
          ),
        );
}
