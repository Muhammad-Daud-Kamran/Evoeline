import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/social_auth_button.dart';
import 'screen_5_sign_up.dart';

class Screen4Login extends StatefulWidget {
  const Screen4Login({super.key});

  @override
  State<Screen4Login> createState() => _Screen4LoginState();
}

class _Screen4LoginState extends State<Screen4Login> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Text(
                'EventFlow',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 48),

              // Email Field
              const AuthTextField(hintText: 'Email Address'),
              const SizedBox(height: 16),

              // Password Field
              const AuthTextField(hintText: 'Password', isObscure: true),
              const SizedBox(height: 16),

              // Remember Me & Forgot Password
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
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
                  const SizedBox(width: 8),
                  const Text(
                    'Remember Me',
                    style: TextStyle(fontSize: 14, color: AppColors.darkText),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    // Forgot Password Action
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Login Button
              CustomButton(
                text: 'Login',
                onPressed: () {
                  // Login Action
                },
              ),
              const SizedBox(height: 24),

              // OR Divider
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.dividerColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightText.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.dividerColor)),
                ],
              ),
              const SizedBox(height: 24),

              // Social Login
              SocialAuthButton(
                text: 'Sign in with Google',
                icon: Icons
                    .g_mobiledata_rounded, // Assuming material icons for placeholder
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              SocialAuthButton(
                text: 'Sign in with LinkedIn',
                icon: Icons.link, // Placeholder for LinkedIn icon
                onPressed: () {},
              ),
              const SizedBox(height: 48),

              // Bottom Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 14, color: AppColors.lightText),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Screen5SignUp(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w600,
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
}
