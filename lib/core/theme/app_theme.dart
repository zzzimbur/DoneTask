// ============================================================================
// ФАЙЛ: APP THEME - СОВРЕМЕННАЯ ТЕМА С УЧЕТОМ ПЛАТФОРМЫ
// ============================================================================
// ОТВЕЧАЕТ ЗА: Создание адаптивной темы под iOS и Android
//              с использованием системных стилей и шрифтов
// ============================================================================

import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      background: AppColors.background,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    ),
    textTheme: AppTextStyles.textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.primary),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLg,
            vertical: AppConstants.spacingMd,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMd),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
    ),
    useMaterial3: true,
  );
}