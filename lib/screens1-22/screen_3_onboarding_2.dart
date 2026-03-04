import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import 'screen_4_login.dart';

class Screen3Onboarding2 extends StatelessWidget {
  const Screen3Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Illustration Placeholder
                    // TODO: Replace with your actual image asset
                    Container(
                      width: double.infinity,
                      height: 350,
                      color: AppColors.background,
                      child: Center(
                        child: Icon(
                          Icons.workspace_premium, // Certificate icon
                          size: 100,
                          color: AppColors.primaryGreen.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'Professional Blockchain Certificates',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'Award verifiable credentials to all attendees.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.darkText,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Skip Action
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.darkText,
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140, // Slightly wider for 'Get Started'
                    child: CustomButton(
                      text: 'Get Started',
                      onPressed: () {
                        // Navigate to Login
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Screen4Login(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
