import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Reusable Custom Text Field matching the UI styling
class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool isObscure;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.isObscure = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.iconColor)
            : null,
        filled: true,
        fillColor: AppColors.lightGreyBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
