import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listify/utils/screen_size.dart';

class ListifyTextStyle {
  static TextStyle headLine2 = GoogleFonts.quicksand(
    fontSize: ListifySize.width(144),
    fontWeight: FontWeight.bold,
  );
  static TextStyle headLine3 = GoogleFonts.quicksand(
    fontSize: ListifySize.width(42),
    fontWeight: FontWeight.w500,
  );

  static TextStyle headLine4 = GoogleFonts.quicksand(
    fontSize: ListifySize.width(32),
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonText({fontWeight = FontWeight.normal}) =>
      GoogleFonts.quicksand(
        fontSize: ListifySize.width(27),
        fontWeight: fontWeight,
      );

  /// Normal Texts
  static TextStyle bodyText1() => GoogleFonts.quicksand(
        fontSize: ListifySize.width(27),
        fontWeight: FontWeight.normal,
      );

  static TextStyle bodyText2() => GoogleFonts.quicksand(
        fontSize: ListifySize.width(24),
        fontWeight: FontWeight.w500,
      );

  static TextStyle bodyText3() => GoogleFonts.quicksand(
        fontSize: ListifySize.width(22),
        fontWeight: FontWeight.normal,
      );

  static TextStyle bodyText4() => GoogleFonts.quicksand(
        fontSize: ListifySize.width(18),
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
