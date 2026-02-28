import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Item for displaying a speaker's session
class SpeakerSessionItem extends StatelessWidget {
  final String title;
  final String dateTime;
  final bool isLive;
  final String imagePath;

  const SpeakerSessionItem({
    Key? key,
    required this.title,
    required this.dateTime,
    this.isLive = false,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imagePath),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateTime,
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
          if (isLive)
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.successGreen,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
