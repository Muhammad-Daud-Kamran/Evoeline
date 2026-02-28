import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Progress indicator showing current step out of total steps
class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Color activeColor;

  const StepProgressIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    this.activeColor = AppColors.darkText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: currentStep / totalSteps,
        backgroundColor: AppColors.dividerColor,
        valueColor: AlwaysStoppedAnimation<Color>(activeColor),
        minHeight: 8,
      ),
    );
  }
}
