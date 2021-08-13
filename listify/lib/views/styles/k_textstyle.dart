import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/styles/k_colors.dart';
import 'package:listify/views/styles/k_size.dart';

class KTextStyle {
  static TextStyle headLine3 = GoogleFonts.poppins(
    fontSize: KSize.getWidth(NavigationService.navigatorKey.currentContext, 42),
    fontWeight: FontWeight.w500,
  );
  static TextStyle buttonText({fontWeight = FontWeight.normal}) => GoogleFonts.poppins(
        fontSize: KSize.getWidth(NavigationService.navigatorKey.currentContext, 27),
        fontWeight: fontWeight,
      );

  /// Normal Texts
  static TextStyle bodyText1() => GoogleFonts.poppins(
        fontSize: KSize.getWidth(NavigationService.navigatorKey.currentContext, 27),
        fontWeight: FontWeight.normal,
      );
  static TextStyle bodyText2() => GoogleFonts.poppins(
        fontSize: KSize.getWidth(NavigationService.navigatorKey.currentContext, 24),
        fontWeight: FontWeight.w500,
      );
  static TextStyle bodyText3() => GoogleFonts.poppins(
        fontSize: KSize.getWidth(NavigationService.navigatorKey.currentContext, 22),
        fontWeight: FontWeight.normal,
      );
}
