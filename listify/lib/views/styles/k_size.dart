// w 720
// h 1600

import 'package:flutter/material.dart';

class KSize {
  static double getWidth(BuildContext context, width) {
    double _width = (((100 / 720) * width) / 100) * MediaQuery.of(context).size.width;
    return _width;
  }

  static double getHeight(BuildContext context, heigth) {
    double _height = (((100 / 1600) * heigth) / 100) * MediaQuery.of(context).size.height;
    return _height;
  }
}
