import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Single item representation for an attendee in the list
class AttendeeListItem extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool isCheckedIn;
  final String? avatarImagePath;
  final Color? subtitleColor;
  final String? statusText; // Schema: confirmed, pending, checked_in, etc.
  final String? paymentStatus; // Schema: paid, unpaid, partially_paid
  final String? paymentAmount;

  const AttendeeListItem({
    Key? key,
    required this.name,
    required this.subtitle,
    required this.isCheckedIn,
    this.avatarImagePath,
    this.subtitleColor,
    this.statusText,
    this.paymentStatus,
    this.paymentAmount,
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
            backgroundImage: avatarImagePath != null ? AssetImage(avatarImagePath!) : null,
            child: avatarImagePath == null
                ? Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '',
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
                if (statusText != null || paymentStatus != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (statusText != null)
                        _buildBadge(statusText!, AppColors.primaryGreen.withOpacity(0.1), AppColors.primaryGreen),
                      if (paymentStatus != null) ...[
                        const SizedBox(width: 8),
                        _buildBadge(
                          '${paymentStatus!} ${paymentAmount != null ? "($paymentAmount)" : ""}',
                          paymentStatus!.toLowerCase() == 'paid' ? Colors.blue.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                          paymentStatus!.toLowerCase() == 'paid' ? Colors.blue : Colors.orange,
                        ),
                      ],
                    ],
                  ),
                ],
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

  Widget _buildBadge(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
