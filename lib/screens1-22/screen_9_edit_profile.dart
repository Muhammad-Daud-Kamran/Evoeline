import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../viewmodels/profile_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';

class Screen9EditProfile extends ConsumerStatefulWidget {
  const Screen9EditProfile({super.key});

  @override
  ConsumerState<Screen9EditProfile> createState() => _Screen9EditProfileState();
}

class _Screen9EditProfileState extends ConsumerState<Screen9EditProfile> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;
  late TextEditingController _companyController;
  late TextEditingController _designationController;
  late TextEditingController _deptController;
  late TextEditingController _expController;
  late TextEditingController _linkedInController;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider).profileInfo;
    _nameController = TextEditingController(text: profile?.fullName ?? 'Sophia Carter');
    _emailController = TextEditingController(text: profile?.email ?? 'sophia@example.com');
    _phoneController = TextEditingController(text: profile?.phoneNumber ?? '+1 234 567 8900');
    _dobController = TextEditingController(text: '1990-01-01');
    _genderController = TextEditingController(text: profile?.gender ?? 'Female');
    _companyController = TextEditingController(text: 'Tech Innovators Inc.');
    _designationController = TextEditingController(text: 'Event Coordinator');
    _deptController = TextEditingController(text: 'Marketing');
    _expController = TextEditingController(text: '5');
    _linkedInController = TextEditingController(text: 'linkedin.com/in/sophiacarter');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _companyController.dispose();
    _designationController.dispose();
    _deptController.dispose();
    _expController.dispose();
    _linkedInController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _saveProfile() async {
    final profileState = ref.read(profileProvider);
    final updatedUser = profileState.profileInfo?.copyWith(
          fullName: _nameController.text,
          email: _emailController.text,
          phoneNumber: _phoneController.text,
          gender: _genderController.text,
        ) ??
        UserModel.empty();

    await ref.read(profileProvider.notifier).updateProfile(updatedUser);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

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
        child: profileState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar Thumbnail
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile photo picker simulation')),
                        );
                      },
                      child: Image.asset(
                        'assets/images/Screen_9_1.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(_nameController.text, style: AppTextStyles.heading2),
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
              _buildLabeledInput('Full Name', controller: _nameController),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'Email Address',
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'Phone Number',
                controller: _phoneController,
              ),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'Date of Birth',
                controller: _dobController,
                trailingIcon: Icons.calendar_today_outlined,
                onTap: () {
                  _selectDate();
                },
                readOnly: true,
              ),
              const SizedBox(height: 16),
              _buildLabeledInput('Gender', controller: _genderController),

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
                controller: _companyController,
              ),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'Designation',
                controller: _designationController,
              ),
              const SizedBox(height: 16),
              _buildLabeledInput('Department', controller: _deptController),
              const SizedBox(height: 16),
              _buildLabeledInput('Experience (Years)', controller: _expController),
              const SizedBox(height: 16),
              _buildLabeledInput(
                'LinkedIn URL',
                controller: _linkedInController,
              ),

              const SizedBox(height: 48),

              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: profileState.isSaving ? 'Saving...' : 'Save Changes',
                      onPressed: profileState.isSaving
                          ? null
                          : () {
                              _saveProfile();
                            },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.pop(),
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
    required TextEditingController controller,
    IconData? trailingIcon,
    VoidCallback? onTap,
    bool readOnly = false,
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
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    readOnly: readOnly,
                    onTap: onTap,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
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
        ),
      ],
    );
  }
}
