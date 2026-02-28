import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Reusable stat card with a solid background and no border
class SolidStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;

  const SolidStatCard({
    Key? key,
    required this.title,
    required this.value,
    this.backgroundColor = AppColors.lightGreyBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodyText),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.heading1),
        ],
      ),
    );
  }
}
