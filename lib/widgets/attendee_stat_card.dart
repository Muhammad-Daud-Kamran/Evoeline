import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Small stat card for Attendees screen
class AttendeeStatCard extends StatelessWidget {
  final String title;
  final String value;

  const AttendeeStatCard({Key? key, required this.title, required this.value})
    : super(key: key);

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
          Text(value, style: AppTextStyles.heading1),
        ],
      ),
    );
  }
}
