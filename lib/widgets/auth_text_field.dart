import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Reusable Auth Text Field specifically designed for authentication screens
class AuthTextField extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final Widget? trailingIcon;

  const AuthTextField({
    super.key,
    required this.hintText,
    this.isObscure = false,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.lightText.withValues(alpha: 0.8),
          fontSize: 14,
        ),
        suffixIcon: trailingIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: trailingIcon,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1),
        ),
      ),
    );
  }
}
