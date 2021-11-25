// w 720
// h 1600

import 'package:get/get.dart';

class KSize {
  static double getWidth(width) {
    double _width = (((100 / 720) * width) / 100) * Get.width;
    return _width;
  }

  static double getHeight(heigth) {
    double _height = (((100 / 1600) * heigth) / 100) * Get.height;
    return _height;
  }
}
