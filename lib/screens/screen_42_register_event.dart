import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/outlined_text_field.dart';

/// Screen 42: Register for Event
class Screen42RegisterEvent extends StatefulWidget {
  const Screen42RegisterEvent({super.key});

  @override
  State<Screen42RegisterEvent> createState() => _Screen42RegisterEventState();
}

class _Screen42RegisterEventState extends State<Screen42RegisterEvent> {
  // State variables for form fields
  bool _previousAttendance = false;
  bool _session1 = false;
  bool _session2 = false;
  bool _session3 = false;

  bool _agreeTerms = false;
  bool _agreePrivacy = false;
  bool _agreeMarketing = false;

  final List<String> _hearAboutUsOptions = [
    'Social Media',
    'University Club',
    'Email Newsletter',
    'Friend/Colleague',
    'Other',
  ];
  String? _selectedHearAboutUs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Register for Event',
          style: TextStyle(
            color: AppColors.darkText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.iconColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: AppColors.iconColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personal Information
            _buildSectionTitle('Personal Information'),
            const SizedBox(height: 16),
            const OutlinedTextField(
              label: 'Full Name',
              hintText: 'Enter your full name',
            ),
            const SizedBox(height: 16),
            const OutlinedTextField(
              label: 'Email',
              hintText: 'Enter your email',
            ),
            const SizedBox(height: 16),
            const OutlinedTextField(
              label: 'Phone Number',
              hintText: 'Enter your phone number',
            ),
            const SizedBox(height: 24),

            // Professional Information
            _buildSectionTitle('Professional Information'),
            const SizedBox(height: 16),
            const OutlinedTextField(
              label: 'Company Name',
              hintText: 'Enter your company name',
            ),
            const SizedBox(height: 16),
            const OutlinedTextField(
              label: 'Designation',
              hintText: 'Enter your designation',
            ),
            const SizedBox(height: 16),
            _buildDropdownField('Industry'),
            const SizedBox(height: 24),

            // Event-Specific Questions
            _buildSectionTitle('Event-Specific Questions'),
            const SizedBox(height: 16),
            const OutlinedTextField(
              label: 'What are your expectations from this event?',
              hintText: '',
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Previous Attendance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Have you attended before?',
                      style: TextStyle(
                        color: AppColors.lightText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: _previousAttendance,
                  onChanged: (val) => setState(() => _previousAttendance = val),
                  activeTrackColor: AppColors.primaryGreen.withValues(
                    alpha: 0.5,
                  ),
                  activeThumbColor: AppColors.primaryGreen,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildCheckboxTile(
              'Session 1',
              _session1,
              (val) => setState(() => _session1 = val!),
            ),
            _buildCheckboxTile(
              'Session 2',
              _session2,
              (val) => setState(() => _session2 = val!),
            ),
            _buildCheckboxTile(
              'Session 3',
              _session3,
              (val) => setState(() => _session3 = val!),
            ),
            const SizedBox(height: 24),

            // Preferences & Requirements
            _buildSectionTitle('Preferences & Requirements'),
            const SizedBox(height: 16),
            _buildDropdownField('Dietary Preferences'),
            const SizedBox(height: 16),
            const OutlinedTextField(
              label: 'Accessibility Requirements',
              hintText: '',
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(
                  child: OutlinedTextField(
                    label: 'Emergency Contact Name',
                    hintText: 'Enter name',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedTextField(
                    label: 'Emergency Contact Phone',
                    hintText: 'Enter phone',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // How Did You Hear About Us?
            _buildSectionTitle('How Did You Hear About Us?'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _hearAboutUsOptions.map((option) {
                final isSelected = _selectedHearAboutUs == option;
                return ChoiceChip(
                  label: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.darkText,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(
                      () => _selectedHearAboutUs = selected ? option : null,
                    );
                  },
                  selectedColor: AppColors.primaryGreen,
                  backgroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primaryGreen
                          : AppColors.dividerColor,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Terms, Privacy, and Marketing Consent
            _buildSectionTitle('Terms, Privacy, and Marketing Consent'),
            const SizedBox(height: 16),
            _buildCheckboxTile(
              'I agree to the Terms and Conditions',
              _agreeTerms,
              (val) => setState(() => _agreeTerms = val!),
            ),
            _buildCheckboxTile(
              'I have read and accept the Privacy Policy',
              _agreePrivacy,
              (val) => setState(() => _agreePrivacy = val!),
            ),
            _buildCheckboxTile(
              'I agree to receive marketing communications (optional)',
              _agreeMarketing,
              (val) => setState(() => _agreeMarketing = val!),
            ),
            const SizedBox(height: 32),

            // Register Now Button
            CustomButton(text: 'Register Now', onPressed: () {}),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.darkText,
      ),
    );
  }

  Widget _buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text(
                'Select',
                style: TextStyle(color: AppColors.lightText),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.iconColor,
              ),
              items: const [],
              onChanged: (value) {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxTile(
    String title,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primaryGreen,
              side: const BorderSide(color: AppColors.dividerColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, color: AppColors.darkText),
            ),
          ),
        ],
      ),
    );
  }
}
