import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  static final gray = Color.fromARGB(255, 34, 34, 34);
  static final offWhite = Color.fromARGB(255, 239, 239, 239);
  static final primary = Colors.teal.shade300;
}

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: AppColors.offWhite,
      primary: AppColors.primary
    )
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: AppColors.gray,
      primary: AppColors.primary,
    )
);