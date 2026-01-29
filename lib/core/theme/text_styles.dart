import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextTheme get textTheme => TextTheme(
        displayLarge: headlineLarge.copyWith(color: AppColors.textPrimary),
        displayMedium: headlineMedium.copyWith(color: AppColors.textPrimary),
        headlineMedium: headlineMedium.copyWith(color: AppColors.textPrimary),
        titleLarge: titleLarge.copyWith(color: AppColors.textPrimary),
        bodyLarge: bodyLarge.copyWith(color: AppColors.textPrimary),
        bodyMedium: bodyMedium.copyWith(color: AppColors.textSecondary),
      );
}