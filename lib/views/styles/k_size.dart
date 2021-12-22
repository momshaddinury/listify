// w 720
// h 1600

import 'package:flutter/material.dart';
import 'package:listify/services/navigation_service.dart';

class KSize {
  static double getWidth(width) {
    double _width = (width / 720) * MediaQuery.of(Navigation.key.currentContext).size.width;
    return _width;
  }

  static double getHeight(height) {
    double _height = (height / 1600) * MediaQuery.of(Navigation.key.currentContext).size.height;
    return _height;
  }
}
