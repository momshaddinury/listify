import 'package:get/get.dart';
import 'package:listify/views/styles/styles.dart';

kSnackBar(title, message) => Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: KColors.lightRed,
    );
