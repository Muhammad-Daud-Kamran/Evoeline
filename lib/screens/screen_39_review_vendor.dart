import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import '../viewmodels/submit_review_viewmodel.dart';

/// Screen 39: Rate & Review Vendor
class Screen39ReviewVendor extends ConsumerWidget {
  const Screen39ReviewVendor({super.key});

  final List<String> _prosConsOptions = const [
    'Professional Staff',
    'On-time Delivery',
    'High Quality',
    'Great Communication',
    'Value for Money',
    'Smooth Setup',
    'Late Response',
    'High Cost',
    'Delayed Delivery',
    'Limited Options',
    'Miscommunication',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(submitReviewProvider);
    final viewModel = ref.read(submitReviewProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Rate & Review Vendor',
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
            icon: const Icon(Icons.help_outline, color: AppColors.iconColor),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Review submitted successfully')),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor Info Header
            _buildVendorHeader(),
            const SizedBox(height: 24),

            // Overall Rating
            Center(
              child: Column(
                children: [
                  _buildStarRating(
                    state.overallRating,
                    (rating) => viewModel.setOverallRating(rating),
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap to rate your overall experience',
                    style: TextStyle(
                      color: AppColors.primaryGreen,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Detailed Ratings
            _buildSectionTitle('Detailed Ratings'),
            const SizedBox(height: 16),
            _buildDetailedRatingRow(
              'Quality of Service',
              state.qualityRating,
              (r) => viewModel.setDetailedRating('quality', r),
            ),
            _buildDetailedRatingRow(
              'Professionalism',
              state.professionalismRating,
              (r) => viewModel.setDetailedRating('professionalism', r),
            ),
            _buildDetailedRatingRow(
              'Value for Money',
              state.valueRating,
              (r) => viewModel.setDetailedRating('value', r),
            ),
            _buildDetailedRatingRow(
              'Communication',
              state.communicationRating,
              (r) => viewModel.setDetailedRating('communication', r),
            ),
            _buildDetailedRatingRow(
              'Timeliness',
              state.timelinessRating,
              (r) => viewModel.setDetailedRating('timeliness', r),
            ),
            const SizedBox(height: 24),

            // Review Text Area
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightGreyBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dividerColor),
              ),
              child: TextField(
                maxLines: 5,
                maxLength: 500,
                onChanged: (val) => viewModel.setReviewText(val),
                decoration: const InputDecoration(
                  hintText: '',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  counterText: '', // Hide default counter
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${state.reviewText.length}/500',
              style: const TextStyle(color: AppColors.lightText, fontSize: 12),
            ),
            const SizedBox(height: 24),

            // Upload Photos
            _buildSectionTitle('Upload Photos (optional)'),
            const SizedBox(height: 16),
            _buildPhotoUploadGrid(),
            const SizedBox(height: 24),

            // Pros & Cons
            _buildSectionTitle('Pros & Cons'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _prosConsOptions.map((option) {
                final isSelected = state.selectedProsCons.contains(option);
                return ChoiceChip(
                  label: Text(
                    option,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkText,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) => viewModel.toggleProCon(option),
                  backgroundColor: AppColors.lightGreyBackground,
                  selectedColor: AppColors.lightGreyBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Recommend Switch
            _buildSectionTitle('Would you recommend this vendor?'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Yes, definitely!',
                  style: TextStyle(color: AppColors.darkText, fontSize: 14),
                ),
                Switch(
                  value: state.recommendVendor,
                  onChanged: (val) => viewModel.setRecommendVendor(val),
                  activeTrackColor: AppColors.primaryGreen.withOpacity(0.5),
                  activeThumbColor: AppColors.primaryGreen,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Submit Button
            CustomButton(
              text: state.isSubmitting ? 'Submitting...' : 'Submit Review',
              onPressed: () => viewModel.submitReview(),
            ),
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
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.darkText,
      ),
    );
  }

  Widget _buildVendorHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Catering Service',
                style: TextStyle(color: AppColors.primaryGreen, fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                'Savory Delights',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.darkText,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Corporate Gala · Oct 12, 2025',
                style: TextStyle(color: AppColors.lightText, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 88,
          height: 68,
          decoration: BoxDecoration(
            color: const Color(0xFF1E3F3D), // matching UI header bg
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage('assets/images/s39image1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedRatingRow(
    String label,
    int rating,
    ValueChanged<int> onRatingChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.darkText, fontSize: 14),
          ),
          _buildStarRating(rating, onRatingChanged, size: 18),
        ],
      ),
    );
  }

  Widget _buildStarRating(
    int rating,
    ValueChanged<int> onChanged, {
    double size = 24,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onChanged(index + 1),
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: AppColors.darkText, // Based on UI, stars are dark gray/black
            size: size,
          ),
        );
      }),
    );
  }

  Widget _buildPhotoUploadGrid() {
    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dividerColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: AppColors.darkText, size: 32),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2A4D4A), // Natural dark green from UI
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.add, color: Colors.white54, size: 24),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightGreyBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.add, color: Colors.white, size: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
