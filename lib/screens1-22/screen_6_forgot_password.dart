import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_text_field.dart';

class Screen6ForgotPassword extends StatelessWidget {
  const Screen6ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Forgot Password',
                style: AppTextStyles.heading1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter your email address below, and we\'ll send\nyou a link to reset your password.',
                style: AppTextStyles.bodyText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Email Input
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Email Address', style: AppTextStyles.heading3),
              ),
              const SizedBox(height: 8),
              const AuthTextField(hintText: 'youremail@example.com'),
              const SizedBox(height: 32),

              // Send Reset Link Button
              CustomButton(text: 'Send Reset Link', onPressed: () {}),
              const SizedBox(height: 16),

              // Resend Link text button
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Resend Link',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Remembered your password? ',
                style: AppTextStyles.subtitle,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Back to Login',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.lightText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
