import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';

class KExpansionTile extends StatelessWidget {
  const KExpansionTile({
    Key key,
    this.title,
    this.trailing,
    this.children,
  }) : super(key: key);

  final Widget title;
  final Widget trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
          dividerColor: KColors.transparent,
          dividerTheme: DividerThemeData(
            space: 0,
            endIndent: 0,
            indent: 0,
            thickness: 0,
          ),
          listTileTheme: ListTileThemeData(
            dense: true,
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0,
          )),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        iconColor: KColors.primary,
        title: title,
        trailing: trailing,
        children: children,
      ),
    );
  }
}
