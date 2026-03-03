import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/outlined_text_field.dart';

/// Screen 31: Register for Event
class Screen32Register extends StatelessWidget {
  const Screen32Register({Key? key}) : super(key: key);

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
        actions: [
          IconButton(
            icon:  SvgPicture.asset(
              'assets/images/s32icon5share.svg',
              colorFilter: const ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
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
                   fit: BoxFit.cover
                 )
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
                  const OutlinedTextField(
                    label: 'Full Name',
                    hintText: 'Enter yourfullname',
                  ),
                  const SizedBox(height: 16),
                  const OutlinedTextField(
                    label: 'Email',
                    hintText: 'Enter youremail',
                  ),
                  const SizedBox(height: 16),
                  const OutlinedTextField(
                    label: 'Phone Number',
                    hintText: 'Enter yourphonenumber',
                  ),
                  const SizedBox(height: 16),
                  const OutlinedTextField(
                    label: 'Dietary Preferences',
                    hintText: 'Select',
                    trailingIcon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.iconColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const OutlinedTextField(
                    label: 'Accessibility Requirements',
                    hintText: '',
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),

                  // Terms Checkbox
                  const _TermsCheckbox(),
                  const SizedBox(height: 24),

                  // Register Button
                  CustomButton(
                    text: 'Register',
                    backgroundColor: AppColors.primaryGreen,
                    onPressed: () {},
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
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s32icon2events.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s32icon3tickets.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s32icon4profile.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),
          ],
        ),
      ),
    );
  }
}

/// A localized stateful widget to handle the checkbox toggle without making the whole screen stateful
class _TermsCheckbox extends StatefulWidget {
  const _TermsCheckbox({Key? key}) : super(key: key);

  @override
  State<_TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<_TermsCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _isChecked,
            onChanged: (val) {
              setState(() {
                _isChecked = val ?? false;
              });
            },
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
