import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Card showing analytics/overview numbers
class OverviewStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? percentage;

  const OverviewStatCard({
    Key? key,
    required this.title,
    required this.value,
    this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodyText),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.heading2),
          if (percentage != null) ...[
            const SizedBox(height: 4),
            Text(
              percentage!,
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.successGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
