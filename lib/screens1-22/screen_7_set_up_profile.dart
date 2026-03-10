import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';

class Screen8SetUpProfile extends StatelessWidget {
  const Screen8SetUpProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Set Up Your Profile', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar Thumbnail
              Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBE9E7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 36,
                    color: AppColors.iconColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Inputs
              _buildOutlinedInput('Enter\nyourorganizationname'),
              const SizedBox(height: 16),
              _buildOutlinedInput('Your\njobtitleorrole'),
              const SizedBox(height: 16),
              _buildOutlinedInput('Department\norteamname'),
              const SizedBox(height: 16),

              // Experience Dropdown Placeholder
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.dividerColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Experience\n1 - 3 years',
                      style: TextStyle(
                        color: AppColors.lightText,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: AppColors.iconColor),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Skills Chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildSkillChip('Event Planning'),
                  _buildSkillChip('Marketing'),
                  _buildSkillChip('Project Management'),
                  _buildSkillChip('Communication'),
                  _buildSkillChip('Budgeting'),
                ],
              ),
              const SizedBox(height: 24),

              // LinkedIn URL
              _buildOutlinedInput('Paste\nyourLinkedInURL'),

              const SizedBox(height: 48),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(text: 'Continue', onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedInput(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintMaxLines: 2,
        hintStyle: const TextStyle(color: AppColors.lightText, fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dividerColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.darkText,
        ),
      ),
    );
  }
}
