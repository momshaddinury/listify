import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listify/views/styles/k_size.dart';

class KTextStyle {
  static TextStyle headLine3 = GoogleFonts.quicksand(
    fontSize: KSize.getWidth(42),
    fontWeight: FontWeight.w500,
  );

  static TextStyle headLine4 = GoogleFonts.quicksand(
    fontSize: KSize.getWidth(32),
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonText({fontWeight = FontWeight.normal}) => GoogleFonts.quicksand(
        fontSize: KSize.getWidth(27),
        fontWeight: fontWeight,
      );

  /// Normal Texts
  static TextStyle bodyText1() => GoogleFonts.quicksand(
        fontSize: KSize.getWidth(27),
        fontWeight: FontWeight.normal,
      );

  static TextStyle bodyText2() => GoogleFonts.quicksand(
        fontSize: KSize.getWidth(24),
        fontWeight: FontWeight.w500,
      );

  static TextStyle bodyText3() => GoogleFonts.quicksand(
        fontSize: KSize.getWidth(22),
        fontWeight: FontWeight.normal,
      );

  /// Subtitles
  static TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );

  static TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
}
