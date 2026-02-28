import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AgendaTimelineItem extends StatelessWidget {
  final String title;
  final String time;
  final bool isLast;

  const AgendaTimelineItem({
    Key? key,
    required this.title,
    required this.time,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline Node & Line
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.lightGreyBackground,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'H3',
                  style: TextStyle(fontSize: 10, color: AppColors.lightText),
                ), // Placeholder icon text
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: AppColors.dividerColor),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyText.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(time, style: AppTextStyles.label),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
