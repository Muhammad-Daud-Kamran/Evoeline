import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Reusable Custom Text Field matching the UI styling
class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool isObscure;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.iconColor)
            : null,
        // TODO: If you want to use a Custom Asset Image instead of IconData here, change this line to:
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Image.asset('assets/images/your_custom_icon.png', width: 20, height: 20),
        // ),
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
