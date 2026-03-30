import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';

class Screen9EditProfile extends StatelessWidget {
  const Screen9EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text('Edit Profile', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar Thumbnail
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBE9E7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.iconColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Sophia Carter', style: AppTextStyles.heading2),
                    const Text(
                      'Update Profile Photo',
                      style: TextStyle(
                        color: AppColors.lightText,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Personal Information
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Personal Information',
                  style: AppTextStyles.heading3,
                ),
              ),
              const SizedBox(height: 16),
              _buildLabeledInput('Full Name', placeholder: 'Sophia Carter'),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'Email Address',
                placeholder: 'sophia@example.com',
              ),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'Phone Number',
                placeholder: '+1 234 567 8900',
              ),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'Date of Birth',
                placeholder: '1990-01-01',
                trailingIcon: Icons.calendar_today_outlined,
              ),
              const SizedBox(height: 16),
              _buildLabeledInput('Gender', placeholder: 'Female'),

              const SizedBox(height: 32),

              // Professional Information
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Professional Information',
                  style: AppTextStyles.heading3,
                ),
              ),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'Company / Organization',
                placeholder: 'Tech Innovators Inc.',
              ),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'Designation',
                placeholder: 'Event Coordinator',
              ),
              const SizedBox(height: 16),
              _buildLabeledInput('Department', placeholder: 'Marketing'),
              const SizedBox(height: 16),
              _buildLabeledInput('Experience (Years)', placeholder: '5'),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'LinkedIn URL',
                placeholder: 'linkedin.com/in/sophiacarter',
              ),

              const SizedBox(height: 48),

              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(text: 'Save Changes', onPressed: () {}),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightGreyBackground,
                        foregroundColor: AppColors.darkText,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledInput(
    String label, {
    String? placeholder,
    IconData? trailingIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  placeholder ?? '',
                  style: const TextStyle(
                    color: AppColors.darkText,
                    fontSize: 14,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(trailingIcon, color: AppColors.iconColor, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}
