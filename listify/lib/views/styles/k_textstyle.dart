import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/styles/k_colors.dart';
import 'package:listify/views/styles/k_size.dart';

class KTextStyle {
  // TODO: Need better naming.
  static TextStyle titleText1 = GoogleFonts.poppins(
    fontSize: KSize.getWidth(NavigationService.navigatorKey.currentContext, 42),
    fontWeight: FontWeight.w500,
    color: KColors.charcoal,
  );

  static TextStyle buttonText({color = KColors.white}) => GoogleFonts.poppins(
        fontSize:
            KSize.getWidth(NavigationService.navigatorKey.currentContext, 27),
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle buttonText1({color = KColors.white}) => GoogleFonts.poppins(
        fontSize:
            KSize.getWidth(NavigationService.navigatorKey.currentContext, 22),
        fontWeight: FontWeight.normal,
        color: color,
      );
  static TextStyle buttonText2({color = KColors.white}) => GoogleFonts.poppins(
        fontSize:
            KSize.getWidth(NavigationService.navigatorKey.currentContext, 24),
        fontWeight: FontWeight.w500,
        color: color,
      );
}
