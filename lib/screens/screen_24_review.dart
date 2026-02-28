import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // 1. Added SVG Import
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/step_progress_indicator.dart';
import '../widgets/accordion_section.dart';

/// Screen 24: Review Screen (Step 5 of 5)
class Screen24Review extends StatelessWidget {
  const Screen24Review({Key? key}) : super(key: key);

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
        title: const Text('Review', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 5 of 5', style: AppTextStyles.bodyText),
            const SizedBox(height: 8),
            const StepProgressIndicator(
              currentStep: 5,
              totalSteps: 5,
              activeColor: AppColors.oliveGreen,
            ),
            const SizedBox(height: 24),
            AccordionSection(
              title: 'Basic Information',
              isExpanded: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Event Name: Tech Summit 2024', style: AppTextStyles.bodyText),
                  SizedBox(height: 4),
                  Text(
                    'Description: A premier tech conference featuring industry leaders...',
                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const AccordionSection(title: 'Schedule'),
            const SizedBox(height: 12),
            const AccordionSection(title: 'Location'),
            const SizedBox(height: 12),
            const AccordionSection(title: 'Registration Settings'),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Save as Draft',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor: AppColors.darkText,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Publish Event',
                    backgroundColor: AppColors.oliveGreen,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // HOW TO USE CUSTOM SVG ICONS:
            // 1. Place your .svg file in 'assets/images/' folder (or any folder declared in pubspec.yaml)
            // 2. Use SvgPicture.asset('assets/images/your_icon.svg')
            // 3. Example commented out below:

            /* 
            SvgPicture.asset(
              'assets/images/home_icon.svg', 
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 28,
            ), 
            */

             SvgPicture.asset(
              'assets/images/homeicon.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 28,
            ),
            SvgPicture.asset(
              'assets/images/searchicon.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 28,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.darkText,
                borderRadius: BorderRadius.circular(8),
              ),
              child:  SvgPicture.asset(
                'assets/images/addicon.svg',
                colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                width: 28,
              ),
            ),
            SvgPicture.asset(
              'assets/images/ticketicon.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 28,
            ),
            SvgPicture.asset(
              'assets/images/profileicon.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 28,
            ),
          ],
        ),
      ),
    );
  }
}
