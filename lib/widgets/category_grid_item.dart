import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CategoryGridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final String imagepath;
  final Color iconColor;

  const CategoryGridItem({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.imagepath,
    required this.iconColor,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagepath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTextStyles.label.copyWith(
            color: AppColors.darkText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
