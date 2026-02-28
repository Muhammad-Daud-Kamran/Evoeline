import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Single item representation for an attendee in the list
class AttendeeListItem extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool isCheckedIn;
  final String? avatarImagePath; // E.g. 'assets/images/user1.png'
  final Color? subtitleColor;

  const AttendeeListItem({
    Key? key,
    required this.name,
    required this.subtitle,
    required this.isCheckedIn,
    this.avatarImagePath,
    this.subtitleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          // Avatar Implementation
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.cardBackground,
            // TODO: To use image assets from the assets folder for avatars, uncomment the backgroundImage handling below
            // backgroundImage: avatarImagePath != null ? AssetImage(avatarImagePath!) : null,
            child: avatarImagePath == null
                ? Text(
                    name[0],
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.primaryGreen,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.heading3),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.subtitle.copyWith(
                    color: subtitleColor ?? AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
          // Status Dot
          if (isCheckedIn)
            Container(
              width: 12,
              height: 12,
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
