// lib/screens/screen_35_vendor_directory.dart

// ─────────────────────────────────────────────────────
// Screen 35 — Vendor Directory
//
// This screen displays vendors in a directory format:
//   - Featured vendors (carousel)
//   - Explore categories (grid)
//   - Popular vendors (list)
//   - Recently viewed (carousel)
//
// MVVM + Riverpod:
//   - Uses vendorDirectoryProvider to get state
//   - Replaces hardcoded data with data from ViewModel
//   - Categories remain static (but could be dynamic)
// ─────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/vendor_featured_card.dart';
import '../widgets/category_grid_item.dart';
import '../widgets/vendor_popular_list_item.dart';
import '../viewmodels/vendor_directory_viewmodel.dart';

class Screen35VendorDirectory extends ConsumerWidget {
  const Screen35VendorDirectory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vendorDirectoryProvider);
    final viewModel = ref.read(vendorDirectoryProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Search Bar and Filter
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          onChanged: viewModel.searchVendors,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.search, color: Colors.grey),
                            hintText: 'Search vendors services categories',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Filter Icon & Sort Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/s35icon1.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => viewModel.sortBy('Popularity'), // Fixed: Wrapped in anonymous function
                      child: Row(
                        children: [
                          Text(
                            'Sort by: Popularity',
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.darkText,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.darkText,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 2. Featured Vendors
                const Text('Featured Vendors', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state.errorMessage.isNotEmpty)
                  Center(child: Text(state.errorMessage))
                else
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.featuredVendors.length,
                      itemBuilder: (_, index) {
                        final vendor = state.featuredVendors[index];
                        return VendorFeaturedCard(
                          title: vendor.businessName,
                          subtitle: vendor.serviceCategories.isNotEmpty
                              ? vendor.serviceCategories.first
                              : '',
                          imagepath: vendor.logoImage,
                          imageColor: const Color(0xFF6B4226), // fallback
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 24),

                // 3. Explore Categories (static grid, but could be dynamic)
                const Text('Explore Categories', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: _buildCategoryGridItems(state.categories),
                ),
                const SizedBox(height: 24),

                // 4. Popular Vendors
                const Text('Popular Vendors', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state.errorMessage.isNotEmpty)
                  Center(child: Text(state.errorMessage))
                else
                  ...state.popularVendors.map((vendor) => VendorPopularListItem(
                    title: vendor.businessName,
                    subtitle: vendor.serviceCategories.isNotEmpty
                        ? vendor.serviceCategories.first
                        : '',
                    badgeColor: const Color(0xFFE7D1B9),
                    imagepath: vendor.logoImage,
                  )),
                const SizedBox(height: 24),

                // 5. Recently Viewed
                const Text('Recently Viewed', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state.errorMessage.isNotEmpty)
                  Center(child: Text(state.errorMessage))
                else
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.recentlyViewed.length,
                      itemBuilder: (_, index) {
                        final vendor = state.recentlyViewed[index];
                        return VendorFeaturedCard(
                          title: vendor.businessName,
                          subtitle: '',
                          imagepath: vendor.logoImage,
                          imageColor: const Color(0xFF6B4226),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 80), // Space for FAB
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.filter,
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.filter_alt, color: Colors.white),
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
              'assets/images/s35icon1vendors.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s35icon2events.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s35icon3message.svg',
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

  // Helper to build category grid items (static for now)
  List<Widget> _buildCategoryGridItems(List<String> categories) {
    // Map each category to its icon/color/image (these are static)
    // You can extend this mapping as needed
    final categoryDetails = {
      'Venues': {
        'icon': Icons.storefront,
        'bgColor': const Color(0xFFF9EDE3),
        'image': 'assets/images/s35image3.jpg',
        'iconColor': const Color(0xFFC48671),
      },
      'Catering': {
        'icon': Icons.restaurant_menu,
        'bgColor': const Color(0xFF2E404F),
        'image': 'assets/images/s35image4.jpg',
        'iconColor': Colors.white,
      },
      'Photography': {
        'icon': Icons.camera_alt,
        'bgColor': const Color(0xFF2E404F),
        'image': 'assets/images/s35image5.jpg',
        'iconColor': Colors.white,
      },
      'Decoration': {
        'icon': Icons.auto_awesome,
        'bgColor': const Color(0xFFF8E7D3),
        'image': 'assets/images/s35image6.jpg',
        'iconColor': const Color(0xFFC48671),
      },
      'AV Equipment': {
        'icon': Icons.speaker,
        'bgColor': const Color(0xFFEFEFEF),
        'image': 'assets/images/s35image7.jpg',
        'iconColor': Colors.grey,
      },
      'Entertainment': {
        'icon': Icons.music_note,
        'bgColor': const Color(0xFFEBEFF2),
        'image': 'assets/images/s35image8.jpg',
        'iconColor': Colors.blueGrey,
      },
      'Security': {
        'icon': Icons.security,
        'bgColor': const Color(0xFFF3F7F6),
        'image': 'assets/images/s35image9.jpg',
        'iconColor': Colors.blueGrey,
      },
      'Transportation': {
        'icon': Icons.directions_car,
        'bgColor': const Color(0xFFDEF1E5),
        'image': 'assets/images/s35image10.jpg',
        'iconColor': Colors.teal,
      },
    };

    return categories.map((category) {
      final details = categoryDetails[category] ?? {
        'icon': Icons.category,
        'bgColor': Colors.grey.shade200,
        'image': '',
        'iconColor': Colors.black54,
      };
      return CategoryGridItem(
        title: category,
        icon: details['icon'] as IconData,
        backgroundColor: details['bgColor'] as Color,
        imagepath: details['image'] as String,
        iconColor: details['iconColor'] as Color,
      );
    }).toList();
  }
}
