import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/review_list_item.dart';
import '../viewmodels/vendor_reviews_viewmodel.dart';

class Screen38VendorReviews extends ConsumerWidget {
  const Screen38VendorReviews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vendorReviewsProvider);

    if (state.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primaryGreen)),
      );
    }
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text('Vendor Reviews', style: AppTextStyles.heading2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.darkText),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Rating Summary Banner
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side (Big Number)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkText,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < state.averageRating.round() ? Icons.star : Icons.star_border,
                            color: const Color(0xFF8CC9EB),
                            size: 16,
                          );
                        }),
                      ),
                      const SizedBox(height: 4),
                      Text('${state.totalReviews} reviews', style: AppTextStyles.label),
                    ],
                  ),
                  const SizedBox(width: 24),

                  // Right side (Progress Bars)
                  Expanded(
                    child: Column(
                      children: [
                        _buildProgressBar(5, state.getRatingPercentage(5), '${(state.getRatingPercentage(5) * 100).toInt()}%'),
                        const SizedBox(height: 4),
                        _buildProgressBar(4, state.getRatingPercentage(4), '${(state.getRatingPercentage(4) * 100).toInt()}%'),
                        const SizedBox(height: 4),
                        _buildProgressBar(3, state.getRatingPercentage(3), '${(state.getRatingPercentage(3) * 100).toInt()}%'),
                        const SizedBox(height: 4),
                        _buildProgressBar(2, state.getRatingPercentage(2), '${(state.getRatingPercentage(2) * 100).toInt()}%'),
                        const SizedBox(height: 4),
                        _buildProgressBar(1, state.getRatingPercentage(1), '${(state.getRatingPercentage(1) * 100).toInt()}%'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Sort By Dropdown Simulator
              const Text('Sort by', style: AppTextStyles.label),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.dividerColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.selectedSortOption, style: AppTextStyles.bodyText),
                    const Icon(Icons.arrow_drop_up, color: AppColors.darkText),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 3. Review List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.reviews.length,
                itemBuilder: (context, index) {
                  final review = state.reviews[index];
                  return ReviewListItem(
                    authorName: review.authorName,
                    reviewText: review.reviewText,
                    ratingTimestampInfo: '${review.overallRating.toInt()} stars • ${review.eventContext}',
                    avatarColor: Color(review.avatarColorValue),
                    avatarInitials: review.authorInitials,
                  );
                },
              ),
              const SizedBox(height: 16),

              // 4. Banner Image (Two spheres on beige background)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCC8B3),
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/s38image1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),

              ),
              const SizedBox(height: 24),

              // 5. Load More Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.lightGreyBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Load More Reviews',
                    style: AppTextStyles.bodyText.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
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
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn), // Selected
              width: 44,
              height: 44,
            ),
            SizedBox(width: 6,),
            SvgPicture.asset(
              'assets/images/s36icone3vendors.svg', // Re-verified filename in assets
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s38icon1review.svg',
              colorFilter: const ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
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

  Widget _buildProgressBar(
    int stars,
    double percentageFilled,
    String percentageText,
  ) {
    return Row(
      children: [
        Text(
          '$stars',
          style: AppTextStyles.label.copyWith(
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentageFilled,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF8CC9EB),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 32,
          child: Text(
            percentageText,
            style: AppTextStyles.label.copyWith(fontSize: 10),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

}
