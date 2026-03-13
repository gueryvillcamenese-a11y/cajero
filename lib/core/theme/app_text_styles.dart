import 'package:flutter/material.dart';
import 'package:cajero/core/theme/app_colors.dart';

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.gray800,
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.gray800,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.gray800,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.gray800,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.gray500,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.gray500,
    letterSpacing: 0.5,
  );
}
