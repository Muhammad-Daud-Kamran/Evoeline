import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Interactive filter chip for attendees list
class AttendeeFilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isActive;

  const AttendeeFilterChip({
    Key? key,
    required this.label,
    this.icon,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.lightGreyBackground : AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? Colors.transparent : AppColors.dividerColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: AppColors.iconColor),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: AppTextStyles.bodyText.copyWith(
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
