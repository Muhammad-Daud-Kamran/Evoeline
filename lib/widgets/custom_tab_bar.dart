import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Reusable tab bar for navigating in Event Details
class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int activeIndex;

  const CustomTabBar({Key? key, required this.tabs, this.activeIndex = 0})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(tabs.length, (index) {
        final isActive = index == activeIndex;
        return Column(
          children: [
            Text(
              tabs[index],
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            const SizedBox(height: 8),
            if (isActive)
              Container(
                height: 3,
                width: 24,
                decoration: BoxDecoration(
                  color: AppColors.darkText,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        );
      }),
    );
  }
}
