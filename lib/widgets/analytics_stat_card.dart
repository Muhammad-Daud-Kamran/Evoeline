import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Stat card for Analytics screen showing title, value, and percentage change.
class AnalyticsStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool isPositive;

  const AnalyticsStatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.change,
    this.isPositive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.analyticsLightGreen, // Light green tint
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.label.copyWith(color: AppColors.darkText),
          ),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.heading2),
          const SizedBox(height: 8),
          Text(
            change,
            style: AppTextStyles.label.copyWith(
              color: isPositive ? AppColors.successGreen : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
