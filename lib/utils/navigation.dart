import 'package:flutter/material.dart';

extension Navigation on Widget {
  static GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();

  /// Holds the information about parent context
  /// For example when navigation from Screen A to Screen B
  /// we can access context of Screen A from Screen B to check if it
  /// came from Screen A. So we can trigger different logic depending on
  /// which screen we navigated from.
  static BuildContext parentContext;

  Future push(context) {
    parentContext = context;
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => this),
    );
  }

  Future pushAndRemoveUntil(context) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => this),
      (route) => false,
    );
  }

  Future pushReplacement(context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => this),
    );
  }

  static void pop(context) {
    return Navigator.pop(context);
  }
}
