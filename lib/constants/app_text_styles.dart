import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles matching the design system
class AppTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
  );

  // Body Texts
  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkText,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.lightText,
  );

  // Labels & Controls
  static const TextStyle label = TextStyle(
    fontSize: 12,
    color: AppColors.lightText,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
