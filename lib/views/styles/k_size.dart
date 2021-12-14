// w 720
// h 1600

import 'package:flutter/material.dart';
import 'package:listify/services/navigation_service.dart';

class KSize {
  static double getWidth(width) {
    double _width = (((100 / 720) * width) / 100) * MediaQuery.of(Navigation.key.currentContext).size.width;
    return _width;
  }

  static double getHeight(height) {
    double _height = (((100 / 1600) * height) / 100) * MediaQuery.of(Navigation.key.currentContext).size.height;
    return _height;
  }
}
