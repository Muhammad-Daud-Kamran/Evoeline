import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Key Information Tile in Event Overview
class InfoListTile extends StatelessWidget {
  final IconData icon; // Placeholder until custom Image asset is provided
  final String title;
  final String subtitle;

  const InfoListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            // TODO: If you want to use custom image icons instead of Flutter Material Icons,
            // replace the Icon widget below with Image.asset:
            // child: Image.asset('assets/images/your_list_icon.png', width: 24, height: 24),
            child: Icon(icon, color: AppColors.iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.heading3),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.subtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
