import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

class CustomTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.primaryColor,
    primaryColor: AppColors.yellow,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xffF8F8F8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      titleLarge: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(color: AppColors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.black,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.yellow),
        foregroundColor: AppColors.yellow,
        backgroundColor: AppColors.yellow,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.yellow,
      brightness: Brightness.light,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.yellow,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
    ),
    cardTheme: CardThemeData(
      color: Colors.grey.shade800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.white),
      titleLarge: TextStyle(color: AppColors.yellow),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.black,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.yellow),
        foregroundColor: AppColors.yellow,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.yellow,
      brightness: Brightness.dark,
    ),
  );
}
