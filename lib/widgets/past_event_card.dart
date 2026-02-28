import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Card for past events in a horizontal list
class PastEventCard extends StatelessWidget {
  final String title;
  final String year;
  final String imagePath;

  const PastEventCard({Key? key, required this.title, required this.year,
  required this.imagePath})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(8),
              // TODO: To add event image:
              image: DecorationImage(
                image: AssetImage(imagePath), // 👈 using imagePath
                fit: BoxFit.cover,
              ),
            ),

          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w600),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            year,
            style: AppTextStyles.label.copyWith(color: AppColors.successGreen),
          ),
        ],
      ),
    );
  }
}
