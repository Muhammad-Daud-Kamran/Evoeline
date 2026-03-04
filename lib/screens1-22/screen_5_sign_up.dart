import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/role_selection_toggle.dart';

class Screen5SignUp extends StatefulWidget {
  const Screen5SignUp({super.key});

  @override
  State<Screen5SignUp> createState() => _Screen5SignUpState();
}

class _Screen5SignUpState extends State<Screen5SignUp> {
  bool agreeTerms = false;
  String currentRole = 'Attendee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar with Back Arrow and Title
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24), // Spacer for centering title
                  const Text(
                    'EventFlow',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.darkText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Full Name
              AuthTextField(
                hintText: 'Full Name',
                trailingIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),

              // Email Address
              AuthTextField(
                hintText: 'Email Address',
                trailingIcon: Icon(
                  Icons.mail_outline,
                  color: AppColors.iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),

              // Password
              AuthTextField(
                hintText: 'Password',
                isObscure: true,
                trailingIcon: Icon(
                  Icons.visibility_outlined,
                  color: AppColors.iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),

              // Confirm Password
              AuthTextField(
                hintText: 'Confirm Password',
                isObscure: true,
                trailingIcon: Icon(
                  Icons.visibility_outlined,
                  color: AppColors.iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number
              AuthTextField(
                hintText: 'Phone Number (e.g 03XX-XXXXXXX)',
                trailingIcon: Icon(
                  Icons.phone_outlined,
                  color: AppColors.iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(height: 24),

              // Role Toggle
              RoleSelectionToggle(
                onRoleSelected: (role) {
                  setState(() {
                    currentRole = role;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Terms & Conditions Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: agreeTerms,
                      onChanged: (value) {
                        setState(() {
                          agreeTerms = value ?? false;
                        });
                      },
                      activeColor: AppColors.primaryGreen,
                      side: BorderSide(
                        color: AppColors.dividerColor,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'I agree to the Terms and Conditions.',
                    style: TextStyle(fontSize: 14, color: AppColors.darkText),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sign Up Button
              CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  // Sign Up Action
                },
              ),
              const SizedBox(height: 48),

              // Bottom Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 14, color: AppColors.lightText),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
