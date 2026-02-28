import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// Reusable collapsible accordion widget for Review Screen
class AccordionSection extends StatelessWidget {
  final String title;
  final Widget? child;
  final bool isExpanded;

  const AccordionSection({
    Key? key,
    required this.title,
    this.child,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        // Remove the default expansion tile borders
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          title: Text(title, style: AppTextStyles.heading3),
          iconColor: AppColors.darkText,
          collapsedIconColor: AppColors.darkText,
          childrenPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          children: child != null ? [child!] : [],
        ),
      ),
    );
  }
}
