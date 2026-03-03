import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class ReviewListItem extends StatelessWidget {
  final String authorName;
  final String ratingTimestampInfo;
  final String reviewText;
  final String? avatarInitials;
  final Color avatarColor;

  const ReviewListItem({
    Key? key,
    required this.authorName,
    required this.ratingTimestampInfo,
    required this.reviewText,
    this.avatarInitials,
    this.avatarColor = AppColors.avatarGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: avatarColor,
            radius: 24,
            child: avatarInitials != null
                ? Text(
                    avatarInitials!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      authorName,
                      style: AppTextStyles.bodyText.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Mark Helpful',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.darkText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  reviewText,
                  style: AppTextStyles.bodyText.copyWith(
                    color: const Color(0xFF425662),
                  ),
                  strutStyle: const StrutStyle(height: 1.4),
                ),
                const SizedBox(height: 8),
                Text(
                  ratingTimestampInfo,
                  style: AppTextStyles.label.copyWith(
                    color: const Color(0xFF6F899A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
