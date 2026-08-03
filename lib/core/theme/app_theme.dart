import 'package:flutter/material.dart';
import 'theme.dart';

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
        // Великі цифри (наприклад, бали у рейтингу)
        titleLarge: TextStyle(
          fontSize: AppDimensions.fontDisplay, // Розмір шрифта 28.0
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextPrimary,
        ),
        // Для назви уроків, заголовки екранів
        titleMedium: TextStyle(
          fontSize: AppDimensions.fontTitle, // Розмір шрифта 22.0
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextPrimary,
        ),
        // Текст для запитань під час уроків
        bodyLarge: TextStyle(
          fontSize: AppDimensions.fontSubheading, // Розмір шрифта 18.0
          color: AppColors.lightTextPrimary,
          height: AppDimensions.spaceXXXXS,
        ),
        // Основний текст правил, відповідей
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontBody, // Розмір шрифта 16.0
          color: AppColors.lightTextPrimary,
          height: AppDimensions.spaceXXXXS,
        ),
        // Маленький текст, підписи, дрібні підказки
        bodySmall: TextStyle(
          fontSize: AppDimensions.fontCaption, // Розмір шрифта 12.0
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
      //Налаштування віджета TextFromField
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.disabled,
        labelStyle: const TextStyle(color: AppColors.lightTextSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceM,
          vertical: AppDimensions.spaceM,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.primaryShadow),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.primary, width: 3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),
      //Колір курсора віджета TextFromField
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primary,
      ),
      //Налаштування віджета TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.lightTextPrimary,
          textStyle: const TextStyle(
            fontSize: AppDimensions.fontBody,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: AppColors.primary,
        labelTextStyle: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.fontBody,
              color: AppColors.lightTextPrimary,
            );
          } else {
            return const TextStyle(
              fontSize: AppDimensions.fontCaption,
              color: AppColors.lightTextSecondary,
            );
          }
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightBorder,
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
        // Великі цифри (наприклад, бали у рейтингу)
        titleLarge: TextStyle(
          fontSize: AppDimensions.fontDisplay,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
        // Для назви уроків, заголовки екранів
        titleMedium: TextStyle(
          fontSize: AppDimensions.fontTitle,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
        // Текст для запитань під час уроків
        bodyLarge: TextStyle(
          fontSize: AppDimensions.fontSubheading,
          color: AppColors.darkTextPrimary,
          height: AppDimensions.spaceXXXXS,
        ),
        // Основний текст правил, відповідей
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontBody,
          color: AppColors.darkTextPrimary,
          height: AppDimensions.spaceXXXXS,
        ),
        // Маленький текст, підписи, дрібні підказки
        bodySmall: TextStyle(
          fontSize: AppDimensions.fontCaption,
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
      //Налаштування віджета TextFromField
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkTextSecondary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceM,
          vertical: AppDimensions.spaceM,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.darkTextSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.disabled, width: 3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),
      //Колір курсора віджета TextFromField
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.darkBorder,
      ),
      //Налаштування віджета TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.darkTextPrimary,
          textStyle: const TextStyle(
            fontSize: AppDimensions.fontBody,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: AppColors.primary,
        labelTextStyle: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.fontBody,
              color: AppColors.darkTextPrimary,
            );
          } else {
            return const TextStyle(
              fontSize: AppDimensions.fontCaption,
              color: AppColors.darkTextSecondary,
            );
          }
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkBorder,
      ),
    );
  }
}
