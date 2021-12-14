import 'package:flutter/material.dart';

extension Navigation on Widget {
  static GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();

  Future<T> push<T extends Navigator>(context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => this),
    );
  }

  Future<T> pushAndRemoveUntil<T extends Navigator>(context) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => this),
      (route) => false,
    );
  }

  Future<T> pushReplacement<T extends Navigator>(context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => this),
    );
  }

  static void pop(context) {
    return Navigator.pop(context);
  }
}
