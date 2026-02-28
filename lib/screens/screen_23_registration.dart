import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/registration_card.dart';
import '../widgets/step_progress_indicator.dart';

/// Screen 23: Create Event (Step 4 of 5 - Registration)
/// To add images, drop them into your 'assets/images' folder.
class Screen23Registration extends StatelessWidget {
  const Screen23Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Create Event', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Step 4 of 5 - Registration',
              style: AppTextStyles.bodyText,
            ),
            const SizedBox(height: 8),
            const StepProgressIndicator(currentStep: 4, totalSteps: 5),
            const SizedBox(height: 24),

            // Enable Registration Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enable Registration',
                  style: AppTextStyles.bodyText,
                ),
                Switch(
                  value: false,
                  onChanged: (val) {},
                  activeColor: AppColors.primaryGreen,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Registration Schedule Card
            const RegistrationCard(
              title: 'Registration Schedule',
              description: 'Set the dates when registration opens and closes.',
              buttonText: 'Set Dates',
              iconData: Icons.calendar_today_outlined,
              imagePath: 'assets/images/registrationpage_image1.jpg',
            ),
            const SizedBox(height: 24),

            // Capacity & Payment Card
            const RegistrationCard(
              title: 'Capacity & Payment',
              description:
                  'Manage event capacity, waitlist, and ticket pricing.',
              buttonText: 'Configure',
              iconData: Icons.confirmation_num_outlined,
              imagePath: 'assets/images/registrationpage_image2.jpg',
            ),
            const SizedBox(height: 32),

            // Custom Registration Fields section
            const Text(
              'Custom Registration Fields',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Field Name', style: AppTextStyles.bodyText),
                    Text('Text', style: AppTextStyles.subtitle),
                  ],
                ),
                Switch(
                  value: false,
                  onChanged: (val) {},
                  activeColor: AppColors.primaryGreen,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 120, // To match the design's "Add Field" button length
              child: CustomButton(
                text: 'Add Field',
                backgroundColor: AppColors.lightGreyBackground,
                textColor: AppColors.darkText,
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                text: 'Back',
                backgroundColor: AppColors.lightGreyBackground,
                textColor: AppColors.darkText,
                width: 100,
                onPressed: () {},
              ),
              CustomButton(
                text: 'Next',
                backgroundColor: AppColors.primaryGreen,
                width: 100,
                onPressed: () {}, // Navigate to Review Step
              ),
            ],
          ),
        ),
      ),
    );
  }
}
