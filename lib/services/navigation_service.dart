import 'package:flutter/material.dart';

extension Navigation on Navigator {
  static GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();

  static Future<T> push<T extends Object>(context, Widget widget) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static Future<T> pushAndRemoveUntil<T extends Object>(context, Widget widget) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  }

  static Future<T> pushReplacement<T extends Object>(context, Widget widget) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static void pop(context) {
    return Navigator.pop(context);
  }
}
