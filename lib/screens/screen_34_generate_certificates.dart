import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../viewmodels/generate_certificates_viewmodel.dart';

class Screen34GenerateCertificates extends ConsumerWidget {
  const Screen34GenerateCertificates({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generateCertificatesProvider);
    final viewModel = ref.read(generateCertificatesProvider.notifier);

    // Show Snackbar on Success or Error
    ref.listen<GenerateCertificatesState>(generateCertificatesProvider, (
      previous,
      next,
    ) {
      if (next.errorMessage.isNotEmpty &&
          (previous?.errorMessage != next.errorMessage)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage)));
      }
      if (next.isSuccess && (previous?.isSuccess != true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Certificates generated successfully!')),
        );
        viewModel.resetSuccess();
        // context.pop(); // Optional
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
        title: const Text(
          'Generate Certificates',
          style: AppTextStyles.heading2,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: AppColors.iconColor),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Showing info'))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Attendees', style: AppTextStyles.heading3),
              const SizedBox(height: 12),

              // Certificate Image Header
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyBackground, // Fallback background
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/s34image1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select All Attendees',
                    style: AppTextStyles.heading3,
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.selectAllAttendees(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      minimumSize: const Size(0, 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Select All',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              state.isLoading && state.attendees.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.attendees.length,
                      itemBuilder: (context, index) {
                        final attendee = state.attendees[index];
                        final isSelected = state.selectedAttendeeIds.contains(
                          attendee.userId,
                        );
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Text(
                              attendee.name.isNotEmpty
                                  ? attendee.name.substring(0, 2).toUpperCase()
                                  : '',
                              style: const TextStyle(color: AppColors.darkText),
                            ),
                          ),
                          title: Text(
                            attendee.name,
                            style: AppTextStyles.bodyText.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            attendee.email,
                            style: AppTextStyles.subtitle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          trailing: Checkbox(
                            value: isSelected,
                            onChanged: (val) {
                              viewModel.toggleAttendeeSelection(
                                attendee.userId,
                              );
                            },
                            activeColor: AppColors.primaryGreen,
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 24),

              const Text('Choose Template', style: AppTextStyles.heading3),
              const SizedBox(height: 12),

              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () => viewModel.selectTemplate('Modern'),
                      child: _buildTemplateItem(
                        'Modern',
                        state.selectedTemplate == 'Modern',
                        'assets/images/s34image2.jpg',
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => viewModel.selectTemplate('Classic'),
                      child: _buildTemplateItem(
                        'Classic',
                        state.selectedTemplate == 'Classic',
                        'assets/images/s34image3.jpg',
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => viewModel.selectTemplate('Minimal'),
                      child: _buildTemplateItem(
                        'Minimal',
                        state.selectedTemplate == 'Minimal',
                        'assets/images/s34image4.png',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFDCCDBE),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/s34image5.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text('Certificate Details', style: AppTextStyles.heading3),
              const SizedBox(height: 12),

              const Text('Signatory Name', style: AppTextStyles.label),
              const SizedBox(height: 4),
              CustomTextField(
                hintText: 'Enter name',
                onChanged: viewModel.updateSignatoryName,
              ),
              const SizedBox(height: 16),

              const Text('Signatory Title', style: AppTextStyles.label),
              const SizedBox(height: 4),
              CustomTextField(
                hintText: 'e.g., Event Director',
                onChanged: viewModel.updateSignatoryTitle,
              ),
              const SizedBox(height: 16),

              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.upload_file,
                        size: 18,
                        color: AppColors.darkText,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Upload Signature',
                        style: AppTextStyles.bodyText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...state.skills.map((skill) => _buildSkillChip(skill)),
                  _buildSkillChip('+ Add Skill', isAdd: true),
                ],
              ),
              const SizedBox(height: 16),

              const Text(
                'Optional message or note on certificate.',
                style: AppTextStyles.label,
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 4,
                onChanged: viewModel.updateCustomMessage,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.lightGreyBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Blockchain Verification',
                style: AppTextStyles.heading3,
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Enable Blockchain',
                    style: AppTextStyles.bodyText,
                  ),
                  Switch(
                    value: state.isBlockchainEnabled,
                    onChanged: (val) => viewModel.toggleBlockchain(val),
                    activeThumbColor: AppColors.primaryGreen,
                  ),
                ],
              ),
              Text(
                'Estimated Minting Cost: ~0.002 MATIC / certificate',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.primaryGreen,
                ),
              ),
              const SizedBox(height: 16),

              const Text('Network', style: AppTextStyles.label),
              const SizedBox(height: 4),
              CustomTextField(
                hintText: 'Polygon',
                onChanged: viewModel.updateNetwork,
              ),
              const SizedBox(height: 8),
              const Text(
                'Blockchain verification will generate a permanent, verifiable record on Polygon.',
                style: AppTextStyles.label,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening preview...')),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/images/s34icon1preview.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.darkText,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: Text(
                    'Preview Certificate',
                    style: AppTextStyles.buttonText.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: state.isLoading
                      ? null
                      : () => viewModel.generateCertificates(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: state.isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.insert_drive_file_outlined,
                          color: Colors.black,
                        ),
                  label: Text(
                    state.isLoading ? 'Generating...' : 'Generate Certificates',
                    style: AppTextStyles.buttonText.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateItem(String title, bool isSelected, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFF0EAE1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primaryGreen : Colors.transparent,
              width: 2,
            ),
            image: DecorationImage(
              // 👈 replaced color with image
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 4),
        Text(
          title,
          style: AppTextStyles.label.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String text, {bool isAdd = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: AppTextStyles.label.copyWith(
          color: AppColors.darkText,
          fontWeight: isAdd ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
