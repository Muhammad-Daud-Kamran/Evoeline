import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Small tags used in Event Details
class InfoChip extends StatelessWidget {
  final String label;

  const InfoChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: AppTextStyles.bodyText),
    );
  }
}
