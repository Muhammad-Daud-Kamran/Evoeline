import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class HorizontalProgressBar extends StatelessWidget {
  final String label;
  final double progress; // 0.0 to 1.0

  const HorizontalProgressBar({
    Key? key,
    required this.label,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: AppTextStyles.label.copyWith(
                color: AppColors.darkText,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyBackground,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors
                          .analyticsLightGreen, // Light green tint based on design
                      borderRadius: BorderRadius.circular(2),
                      border: const Border(
                        right: BorderSide(
                          color: AppColors.primaryGreen,
                          width: 2,
                        ),
                      ),
                    ),
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
