import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_management/design/app_colors.dart';

double letterSpacing = -.7;
double height = 1.7;
double wordSpacing = 1;

TextStyle titleFonts(Color color) {
  return GoogleFonts.breeSerif(
    fontSize: 40,
    color: color,
    fontWeight: FontWeight.bold,
  );
}

TextStyle googleFonts(double fontSize, Color color, FontWeight fontWeight) {
  return GoogleFonts.baloo2(
    fontSize: fontSize,
    letterSpacing: -.5,
    color: color,
    fontWeight: fontWeight,
    decoration: TextDecoration.none,
  );
}

TextStyle fontAuthenticationPrimTextStyle(context) {
  return googleFonts(30, Theme.of(context).primaryColor, FontWeight.bold);
}

TextStyle selectedText = googleFonts(12, successColor, FontWeight.w400);

///////// TEXTTHEME CLASS DARK
// HEADLINE
TextStyle headlineLargeDark = googleFonts(40, darkTextColor, FontWeight.w800);
TextStyle headlineMediumDark = googleFonts(35, darkTextColor, FontWeight.w800);
TextStyle headlineSmallDark = googleFonts(30, darkTextColor, FontWeight.w800);

// TITLE
TextStyle titleLargeDark = googleFonts(22, darkTextColor, FontWeight.w700);
TextStyle titleMediumDark = googleFonts(20, darkTextColor, FontWeight.w700);
TextStyle titleSmallDark = googleFonts(18, darkTextColor, FontWeight.w700);

// BODY
TextStyle bodyLargeDark = googleFonts(18, darkTextColor, FontWeight.w500);
TextStyle bodyMediumDark = googleFonts(16, darkTextColor, FontWeight.w500);
TextStyle bodySmallDark = googleFonts(14, darkTextColor, FontWeight.w500);

//LABEL
TextStyle labelLargeDark = googleFonts(14, darkTextColor, FontWeight.w400);
TextStyle labelMediumDark = googleFonts(12, darkTextColor, FontWeight.w400);
TextStyle labelSmallDark = googleFonts(10, darkTextColor, FontWeight.w400);

///////// TEXTTHEME CLASS LIGHT
// HEADLINE
TextStyle headlineLargeLight = googleFonts(40, lightTextColor, FontWeight.w800);
TextStyle headlineMediumLight = googleFonts(
  35,
  lightTextColor,
  FontWeight.w800,
);
TextStyle headlineSmallLight = googleFonts(30, lightTextColor, FontWeight.w800);

// TITLE
TextStyle titleLargeLight = googleFonts(22, lightTextColor, FontWeight.w700);
TextStyle titleMediumLight = googleFonts(20, lightTextColor, FontWeight.w700);
TextStyle titleSmallLight = googleFonts(18, lightTextColor, FontWeight.w700);

// BODY
TextStyle bodyLargeLight = googleFonts(18, lightTextColor, FontWeight.w500);
TextStyle bodyMediumLight = googleFonts(16, lightTextColor, FontWeight.w500);
TextStyle bodySmallLight = googleFonts(14, lightTextColor, FontWeight.w500);

//LABEL
TextStyle labelLargeLight = googleFonts(14, lightTextColor, FontWeight.w400);
TextStyle labelMediumLight = googleFonts(12, lightTextColor, FontWeight.w400);
TextStyle labelSmallLight = googleFonts(10, lightTextColor, FontWeight.w400);

List<Shadow> shadows(double offset, double blurRadius, Color color) {
  return <Shadow>[
    Shadow(
      offset: Offset(offset, offset),
      blurRadius: blurRadius,
      color: color,
    ),
  ];
}
