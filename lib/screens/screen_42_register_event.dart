import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/outlined_text_field.dart';
import '../viewmodels/event_registration_viewmodel.dart';

/// Screen 42: Register for Event (MVVM Architecture)
class Screen42RegisterEvent extends ConsumerStatefulWidget {
  const Screen42RegisterEvent({super.key});

  @override
  ConsumerState<Screen42RegisterEvent> createState() =>
      _Screen42RegisterEventState();
}

class _Screen42RegisterEventState extends ConsumerState<Screen42RegisterEvent> {
  // TextEditingControllers for text inputs (avoids rebuild on every keystroke)
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _designationController = TextEditingController();
  final _expectationsController = TextEditingController();
  final _accessibilityController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _designationController.dispose();
    _expectationsController.dispose();
    _accessibilityController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    ref.read(eventRegistrationProvider.notifier).submitRegistration(
      fullName: _fullNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      companyName: _companyController.text,
      designation: _designationController.text,
      expectations: _expectationsController.text,
      accessibilityRequirements: _accessibilityController.text,
      emergencyContactName: _emergencyNameController.text,
      emergencyContactPhone: _emergencyPhoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventRegistrationProvider);
    final vm = ref.read(eventRegistrationProvider.notifier);

    // Show success snackbar
    ref.listen<EventRegistrationState>(eventRegistrationProvider, (prev, next) {
      if (next.successMessage != null &&
          prev?.successMessage != next.successMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage!),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
        context.pop();
      }
    });

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
          onPressed: () => context.pop(),
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
            // ── Personal Information ─────────────────────
            _buildSectionTitle('Personal Information'),
            const SizedBox(height: 16),
            OutlinedTextField(
              label: 'Full Name',
              hintText: 'Enter your full name',
              controller: _fullNameController,
            ),
            const SizedBox(height: 16),
            OutlinedTextField(
              label: 'Email',
              hintText: 'Enter your email',
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            OutlinedTextField(
              label: 'Phone Number',
              hintText: 'Enter your phone number',
              controller: _phoneController,
            ),
            const SizedBox(height: 24),

            // ── Professional Information ──────────────────
            _buildSectionTitle('Professional Information'),
            const SizedBox(height: 16),
            OutlinedTextField(
              label: 'Company Name',
              hintText: 'Enter your company name',
              controller: _companyController,
            ),
            const SizedBox(height: 16),
            OutlinedTextField(
              label: 'Designation',
              hintText: 'Enter your designation',
              controller: _designationController,
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: 'Industry',
              value: state.industry,
              options: EventRegistrationViewModel.industryOptions,
              onChanged: vm.updateIndustry,
            ),
            const SizedBox(height: 24),

            // ── Event-Specific Questions ──────────────────
            _buildSectionTitle('Event-Specific Questions'),
            const SizedBox(height: 16),
            OutlinedTextField(
              label: 'What are your expectations from this event?',
              hintText: '',
              maxLines: 4,
              controller: _expectationsController,
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
                  value: state.previousAttendance,
                  onChanged: vm.togglePreviousAttendance,
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
              state.session1,
              (val) => vm.updateSession(1, val!),
            ),
            _buildCheckboxTile(
              'Session 2',
              state.session2,
              (val) => vm.updateSession(2, val!),
            ),
            _buildCheckboxTile(
              'Session 3',
              state.session3,
              (val) => vm.updateSession(3, val!),
            ),
            const SizedBox(height: 24),

            // ── Preferences & Requirements ────────────────
            _buildSectionTitle('Preferences & Requirements'),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: 'Dietary Preferences',
              value: state.dietaryPreference,
              options: EventRegistrationViewModel.dietaryOptions,
              onChanged: vm.updateDietary,
            ),
            const SizedBox(height: 16),
            OutlinedTextField(
              label: 'Accessibility Requirements',
              hintText: '',
              maxLines: 4,
              controller: _accessibilityController,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedTextField(
                    label: 'Emergency Contact Name',
                    hintText: 'Enter name',
                    controller: _emergencyNameController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedTextField(
                    label: 'Emergency Contact Phone',
                    hintText: 'Enter phone',
                    controller: _emergencyPhoneController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── How Did You Hear About Us? ────────────────
            _buildSectionTitle('How Did You Hear About Us?'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  EventRegistrationViewModel.hearAboutUsOptions.map((option) {
                    final isSelected = state.selectedHearAboutUs == option;
                    return ChoiceChip(
                      label: Text(
                        option,
                        style: TextStyle(
                          color:
                              isSelected ? Colors.white : AppColors.darkText,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) =>
                          vm.toggleHearAboutUs(option, selected),
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

            // ── Consents ─────────────────────────────────
            _buildSectionTitle('Terms, Privacy, and Marketing Consent'),
            const SizedBox(height: 16),
            _buildCheckboxTile(
              'I agree to the Terms and Conditions',
              state.agreeTerms,
              (val) => vm.toggleConsent(terms: val!),
            ),
            _buildCheckboxTile(
              'I have read and accept the Privacy Policy',
              state.agreePrivacy,
              (val) => vm.toggleConsent(privacy: val!),
            ),
            _buildCheckboxTile(
              'I agree to receive marketing communications (optional)',
              state.agreeMarketing,
              (val) => vm.toggleConsent(marketing: val!),
            ),
            const SizedBox(height: 12),

            // Error Message
            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),

            const SizedBox(height: 20),

            // Register Now Button
            state.isSubmitting
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryGreen,
                    ),
                  )
                : CustomButton(text: 'Register Now', onPressed: _handleSubmit),
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

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
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
              value: value,
              hint: const Text(
                'Select',
                style: TextStyle(color: AppColors.lightText),
              ),
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.iconColor),
              items: options
                  .map(
                    (opt) => DropdownMenuItem(value: opt, child: Text(opt)),
                  )
                  .toList(),
              onChanged: onChanged,
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
