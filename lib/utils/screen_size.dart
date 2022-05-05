import 'package:flutter/material.dart';
import 'package:listify/utils/navigation.dart';

class ListifySize {
  static Size get size => MediaQuery.of(Navigation.key.currentContext).size;

  static double width(width) {
    double _width = (width / 720) * (size.width > 700 ? 700 : size.width);
    return _width;
  }

  static double height(height) {
    double _height =
        (height / 1600) * (size.height > 1080 ? 1080 : size.height);
    return _height;
  }
}
