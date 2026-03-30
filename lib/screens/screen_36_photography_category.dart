import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/vendor_category_list_item.dart';
import '../viewmodels/photography_category_viewmodel.dart';

class Screen36PhotographyCategory extends ConsumerWidget {
  const Screen36PhotographyCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(photographyCategoryProvider);
    final viewModel = ref.read(photographyCategoryProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text('Photography', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryGreen))
          : SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Photography', style: AppTextStyles.heading1),
              const SizedBox(height: 8),
              Text(
                'Top-rated professionals for your next event',
                style: AppTextStyles.bodyText.copyWith(
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 24),

              // Filter Chips Scroll View
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', Icons.photo_library_outlined, state.selectedFilter == 'All', viewModel),
                    const SizedBox(width: 8),
                    _buildFilterChip('Wedding', Icons.camera_alt_outlined, state.selectedFilter == 'Wedding', viewModel),
                    const SizedBox(width: 8),
                    _buildFilterChip('Corporate', Icons.business_outlined, state.selectedFilter == 'Corporate', viewModel),
                    const SizedBox(width: 8),
                    _buildFilterChip('Fashion', Icons.checkroom_outlined, state.selectedFilter == 'Fashion', viewModel),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Big Banner Image
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyBackground,
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/s36image1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Vendor List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.filteredPhotographers.length,
                itemBuilder: (context, index) {
                  final vendor = state.filteredPhotographers[index];
                  final categoriesString = vendor.serviceCategories.join(', ');
                  final badgeText = vendor.verificationBadges.isNotEmpty ? vendor.verificationBadges.first : null;
                  
                  return VendorCategoryListItem(
                    title: vendor.businessName,
                    categories: categoriesString,
                    badge: badgeText,
                    badgeColor: AppColors.primaryGreen,
                    imagePath: vendor.logoImage,
                  );
                },
              ),
              const SizedBox(height: 16),

              // Load More Button
              Center(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: AppColors.darkText,
                    size: 16,
                  ),
                  label: Text(
                    'Load More',
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
              'assets/images/s36icon2categories.svg',
              colorFilter: const ColorFilter.mode(AppColors.darkText, BlendMode.srcIn), // Selected
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
              'assets/images/s32icon2events.svg',
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

  Widget _buildFilterChip(String label, IconData icon, bool isSelected, PhotographyCategoryViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.selectFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.lightGreyBackground,
          border: Border.all(
            color: isSelected ? AppColors.dividerColor : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.darkText),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.bodyText.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
