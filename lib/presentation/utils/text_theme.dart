import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puzzlehack/presentation/utils/display_size.dart';

final TextTheme largeDisplayTextTheme = TextTheme(
  headline1: GoogleFonts.workSans(
    fontSize: 102,
    fontWeight: FontWeight.w400,
    letterSpacing: -1.5,
    color: Colors.grey[800],
  ),
  headline2: GoogleFonts.workSans(
    fontSize: 51,
    fontWeight: FontWeight.w400,
    color: Colors.grey[800],
  ),
  headline3: GoogleFonts.workSans(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.1,
    color: Colors.grey[800],
  ),
  headline4: GoogleFonts.workSans(
    fontSize: 27,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.grey[800],
  ),
  subtitle1: GoogleFonts.workSans(
    fontSize: 21,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: Colors.white,
  ),
  subtitle2: GoogleFonts.workSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.workSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.workSans(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    color: Colors.white,
  ),
);

final TextTheme mediumDisplayTextTheme = TextTheme(
  headline1: GoogleFonts.workSans(
    fontSize: 51,
    fontWeight: FontWeight.w400,
    letterSpacing: -1.5,
    color: Colors.grey[800],
  ),
  headline2: GoogleFonts.workSans(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: Colors.grey[800],
  ),
  headline3: GoogleFonts.workSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.1,
    color: Colors.grey[800],
  ),
  headline4: GoogleFonts.workSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.grey[800],
  ),
  subtitle1: GoogleFonts.workSans(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: Colors.white,
  ),
  subtitle2: GoogleFonts.workSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: Colors.grey[600],
  ),
  bodyText1: GoogleFonts.workSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: Colors.grey[600],
  ),
  bodyText2: GoogleFonts.workSans(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.grey[600],
  ),
  button: GoogleFonts.workSans(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: Colors.white,
  ),
);

final TextTheme smallDisplayTextTheme = TextTheme(
  headline1: GoogleFonts.workSans(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: -1.5,
    color: Colors.grey[800],
  ),
  headline2: GoogleFonts.workSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Colors.grey[800],
  ),
  headline3: GoogleFonts.workSans(
    fontSize: 21,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.1,
    color: Colors.grey[800],
  ),
  headline4: GoogleFonts.workSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.grey[800],
  ),
  subtitle1: GoogleFonts.workSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: Colors.white,
  ),
  subtitle2: GoogleFonts.workSans(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: Colors.grey[600],
  ),
  bodyText1: GoogleFonts.workSans(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: Colors.grey[600],
  ),
  bodyText2: GoogleFonts.workSans(
    fontSize: 8,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.grey[600],
  ),
  button: GoogleFonts.workSans(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: Colors.white,
  ),
);

extension SizeAwareTextThemeX on BuildContext {
  TextTheme get sizeAwareTextTheme {
    final displaySize = MediaQuery.of(this).size.displaySize;
    switch (displaySize) {
      case DisplaySize.large:
        return largeDisplayTextTheme;
      case DisplaySize.medium:
        return mediumDisplayTextTheme;

      case DisplaySize.small:
      default:
        return smallDisplayTextTheme;
    }
  }
}
