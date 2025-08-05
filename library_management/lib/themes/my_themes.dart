import 'package:flutter/material.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';

class MyThemes {
  static ThemeData darkTheme(Color primaryColor) {
    return ThemeData(
      scaffoldBackgroundColor: darkBgColor,
      appBarTheme: AppBarTheme(backgroundColor: darkBgColor),
      brightness: Brightness.dark,
      cardColor: darkCardColor,
      colorScheme: ColorScheme.dark(primary: secondaryColor),
      primaryColor: secondaryColor,
      secondaryHeaderColor: darkBgColor,
      highlightColor: primaryColor.withAlpha(70),
      splashColor: primaryColor.withAlpha(70),
      iconTheme: IconThemeData(color: darkTextColor),
      textTheme: TextTheme(
        headlineLarge: headlineLargeDark,
        headlineMedium: headlineMediumDark,
        headlineSmall: headlineSmallDark,
        //
        titleLarge: titleLargeDark,
        titleMedium: titleMediumDark,
        titleSmall: titleSmallDark,
        //
        labelLarge: labelLargeDark,
        labelMedium: labelMediumDark,
        labelSmall: labelSmallDark,
        //
        bodyLarge: bodyLargeDark,
        bodyMedium: bodyMediumDark,
        bodySmall: bodySmallDark,
      ),
    );
  }

  static ThemeData lightTheme(Color primaryColor) {
    return ThemeData(
      scaffoldBackgroundColor: lightBgColor,
      appBarTheme: AppBarTheme(backgroundColor: lightBgColor),
      brightness: Brightness.light,
      cardColor: lightCardColor,
      colorScheme: ColorScheme.light(primary: primaryColor),
      primaryColor: primaryColor,
      secondaryHeaderColor: lightBgColor,
      highlightColor: primaryColor.withAlpha(70),
      splashColor: primaryColor.withAlpha(70),
      iconTheme: IconThemeData(color: lightTextColor),
      textTheme: TextTheme(
        headlineLarge: headlineLargeLight,
        headlineMedium: headlineMediumLight,
        headlineSmall: headlineSmallLight,
        //
        titleLarge: titleLargeLight,
        titleMedium: titleMediumLight,
        titleSmall: titleSmallLight,
        //
        labelLarge: labelLargeLight,
        labelMedium: labelMediumLight,
        labelSmall: labelSmallLight,
        //
        bodyLarge: bodyLargeLight,
        bodyMedium: bodyMediumLight,
        bodySmall: bodySmallLight,
      ),
    );
  }
}
