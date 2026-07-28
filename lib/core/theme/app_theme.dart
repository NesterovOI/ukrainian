import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

abstract class AppTheme {
  // --- СВІТЛА ТЕМА ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.lightSurface,
        error: AppColors.error,
      ),
      // Налаштування текстів за замовчуванням
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontBody,
          color: AppColors.lightTextPrimary,
          height: 1.4, // Зручний інтервал між рядками для читання
        ),
        titleLarge: TextStyle(
          fontSize: AppDimensions.fontTitle,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextPrimary,
        ),
      ),
      //Налаштування для стилю карток (Card)
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          side: const BorderSide(color: AppColors.lightBorder, width: 1.5),
        ),
      ),
    );
  }

  // --- ТЕМНА ТЕМА ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.darkSurface,
        error: AppColors.error,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontBody,
          color: AppColors.darkTextPrimary,
          height: 1.4,
        ),
        titleLarge: TextStyle(
          fontSize: AppDimensions.fontTitle,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          side: const BorderSide(color: AppColors.darkBorder, width: 1.5),
        ),
      ),
    );
  }
}