import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Reusable card component for Registration Screen options
class RegistrationCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final IconData iconData;
  final String? imagePath;

  const RegistrationCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.iconData,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Illustration Container
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imagePath != null
                ? Image.asset(
                    imagePath!,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  )
                : Center(
                    child: Icon(
                      iconData,
                      size: 64,
                      color: AppColors.darkText,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        // Title
        Text(title, style: AppTextStyles.heading3),
        const SizedBox(height: 4),
        // Description and Button
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(description, style: AppTextStyles.subtitle)),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ],
    );
  }
}
