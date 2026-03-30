import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/outlined_text_field.dart';
import '../viewmodels/register_viewmodel.dart';

/// Screen 31: Register for Event
class Screen32Register extends ConsumerWidget {
  const Screen32Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerProvider);
    final viewModel = ref.read(registerProvider.notifier);

    // Show Snackbar on Success or Error
    ref.listen<RegisterState>(registerProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty && (previous?.errorMessage != next.errorMessage)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage)),
        );
      }
      if (next.isSuccess && (previous?.isSuccess != true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful!')),
        );
        viewModel.resetSuccess();
        // Optional: Navigate to next page or pop
        // context.pop();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/s32icon5share.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.darkText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/screen32img1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Meta Data
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date: July 15, 2024',
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.lightText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Time: 9:00 AM - 5:00 PM',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Location: Convention Center, New York',
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.lightText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 90,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground, // Peach background
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/screen32img2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Register for this Event',
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: 24),

                  // Form Fields
                  // Profile Image Upload (From Schema)
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Implement image upload logic
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.lightGreyBackground,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.dividerColor,
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              size: 40,
                              color: AppColors.lightText,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGreen,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  OutlinedTextField(
                    label: 'Full Name',
                    hintText: 'Enter your fullname',
                    initialValue: state.fullName,
                    onChanged: viewModel.updateFullName,
                  ),
                  const SizedBox(height: 16),
                  OutlinedTextField(
                    label: 'Email',
                    hintText: 'Enter your email',
                    initialValue: state.email,
                    onChanged: viewModel.updateEmail,
                  ),
                  const SizedBox(height: 16),
                  OutlinedTextField(
                    label: 'Phone Number',
                    hintText: 'Enter your phone number',
                    initialValue: state.phoneNumber,
                    onChanged: viewModel.updatePhoneNumber,
                  ),
                  const SizedBox(height: 16),

                  // Gender Field (From Schema)
                  OutlinedTextField(
                    label: 'Gender',
                    hintText: 'Select your gender',
                    initialValue: state.gender,
                    onChanged: viewModel.updateGender,
                    trailingIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.iconColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Location Fields (From Schema)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedTextField(
                          label: 'City',
                          hintText: 'Enter city',
                          initialValue: state.city,
                          onChanged: viewModel.updateCity,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedTextField(
                          label: 'Country',
                          hintText: 'Enter country',
                          initialValue: state.country,
                          onChanged: viewModel.updateCountry,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  OutlinedTextField(
                    label: 'Dietary Preferences',
                    hintText: 'Select',
                    initialValue: state.dietaryPreferences,
                    onChanged: viewModel.updateDietary,
                    trailingIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.iconColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedTextField(
                    label: 'Accessibility Requirements',
                    hintText: '',
                    maxLines: 4,
                    initialValue: state.accessibilityRequirements,
                    onChanged: viewModel.updateAccessibility,
                  ),
                  const SizedBox(height: 16),

                  // Terms Checkbox
                  _TermsCheckbox(
                    value: state.termsAccepted,
                    onChanged: (val) => viewModel.updateTerms(val ?? false),
                  ),
                  const SizedBox(height: 24),

                  // Register Button
                  state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'Register',
                          backgroundColor: AppColors.primaryGreen,
                          onPressed: () => viewModel.submitRegistration(),
                        ),
                  const SizedBox(height: 16),

                  // Login Link
                  Center(
                    child: Text(
                      'Already registered? Login here',
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.lightText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              'assets/images/s32icon1home.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s32icon2events.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s32icon3tickets.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s32icon4profile.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
          ],
        ),
      ),
    );
  }
}

/// A stateless widget to handle the checkbox toggle via state
class _TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _TermsCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryGreen,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'I agree to the Terms and Conditions an...',
            style: AppTextStyles.bodyText,
          ),
        ),
      ],
    );
  }
}
