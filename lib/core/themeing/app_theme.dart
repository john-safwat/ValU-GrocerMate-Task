import 'package:flutter/material.dart';
import 'package:valu_task/core/themeing/app_colors.dart';

abstract class AppTheme {
  static ThemeData getTheme({
    required ColorScheme colorScheme,
    required Color textFieldBorderColor,
  }) {
    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        centerTitle: true,
        elevation: 0,
      ),

      textTheme: TextTheme(
        // Use onSurface and onBackground colors for text for readability
        bodyLarge: TextStyle(fontSize: 16, color: colorScheme.onSurface),
        bodyMedium: TextStyle(fontSize: 14, color: colorScheme.onSurface),
        bodySmall: TextStyle(
          fontSize: 12,
          color: colorScheme.onSurface.withAlpha(70),
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        // Consistent styling for text fields
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorderColor, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: textFieldBorderColor.withAlpha(50),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // Use the primary color to indicate focus
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(width: 1.5, color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
    );
  }

  /// Light theme configuration
  static ThemeData lightTheme = getTheme(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.cyan,
      onPrimary: AppColors.white,
      secondary: AppColors.orange,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
    textFieldBorderColor: AppColors.gray,
  );

  /// Dark theme configuration
  static ThemeData darkTheme = getTheme(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.cyan,
      onPrimary: AppColors.black,
      secondary: AppColors.orange,
      onSecondary: AppColors.black,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.white,
    ),
    textFieldBorderColor: AppColors.lightGray,
  );
}
