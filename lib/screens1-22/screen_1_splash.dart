import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class Screen1Splash extends StatelessWidget {
  const Screen1Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40), // Top spacing
              Column(
                children: [
                  const Text(
                    'EventFlow',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Where Events Flow Seamlessly',
                    style: TextStyle(fontSize: 16, color: AppColors.darkText),
                  ),
                  const SizedBox(height: 40),
                  // Progress section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '50',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.darkText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        children: [
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen.withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            height: 8,
                            width:
                                MediaQuery.of(context).size.width *
                                0.45, // roughly 50%
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                'v1.0.0',
                style: TextStyle(fontSize: 14, color: AppColors.primaryGreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
