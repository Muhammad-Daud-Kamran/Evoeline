import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Reusable Outlined Text Field for forms
class OutlinedTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;
  final Widget? trailingIcon;

  const OutlinedTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.lightText.withOpacity(0.6)),
            suffixIcon: trailingIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.dividerColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.dividerColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryGreen,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
