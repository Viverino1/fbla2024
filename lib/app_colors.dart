import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static final backgroundGray = Color.fromARGB(255, 34, 34, 34);
  static final offWhite = Color.fromARGB(255, 239, 239, 239);
  static final gray = Colors.white60;
  static final primary = Colors.teal.shade300;
}

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: AppColors.offWhite,
      primary: AppColors.primary,
        secondary: AppColors.backgroundGray.withOpacity(0.5)
    )
);

ThemeData darkMode = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.dmSerifDisplay(
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
      titleMedium: GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
      titleSmall: GoogleFonts.quicksand(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.gray
      ),
    ),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: AppColors.backgroundGray,
      primary: AppColors.primary,
      secondary: AppColors.gray,
    )
);