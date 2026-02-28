import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Card with a placeholder image on top for statistics
class StatCardWithImage extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon; // Placeholder for image until asset is provided

  const StatCardWithImage({
    Key? key,
    required this.title,
    required this.value,
    this.icon = Icons.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Graphic Placeholder
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            // TODO: Replace Icon with Asset Image when ready
            // Example: child: Image.asset('assets/images/stat_chart.png', fit: BoxFit.contain),
            child: Center(
              child: Icon(icon, color: AppColors.darkText, size: 32),
            ),
          ),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyles.heading3),
          const SizedBox(height: 4),
          Text(value, style: AppTextStyles.subtitle),
        ],
      ),
    );
  }
}
