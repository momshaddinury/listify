import 'package:flutter/material.dart';

extension Navigation on Widget {
  static GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();

  Future push(context) {
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
