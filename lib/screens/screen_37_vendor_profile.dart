import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../viewmodels/vendor_profile_viewmodel.dart';

class Screen37VendorProfile extends ConsumerWidget {
  const Screen37VendorProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vendorProfileProvider);
    final viewModel = ref.read(vendorProfileProvider.notifier);
    final vendor = state.vendor;

    if (state.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primaryGreen)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cover Image and Top Bar
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // Cover Image
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    image: DecorationImage(
                      image: AssetImage('assets/images/s37image1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Custom App Bar overlays
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 16,
                  child: InkWell(
                    onTap: () => context.pop(),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.darkText,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: 16,
                  child: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: SvgPicture.asset(
                        'assets/images/s32icon5share.svg',
                        colorFilter: const ColorFilter.mode(
                          AppColors.darkText,
                          BlendMode.srcIn,
                        ),
                        width: 33,
                        height: 33,
                      ),
                    ),
                  ),
                ),
                // Vendor Avatar
                Positioned(
                  bottom: -40,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: const Color(0xFFBCAAA4), // Brownish
                      backgroundImage: AssetImage(vendor.logoImage.isNotEmpty ? vendor.logoImage : 'assets/images/placeholder.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            // 2. Headings
            Center(
              child: Column(
                children: [
                  Text(vendor.businessName, style: AppTextStyles.heading1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${vendor.averageRating}/5.0 (${vendor.totalReviews} reviews)',
                        style: AppTextStyles.label.copyWith(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyBackground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          vendor.serviceCategories.isNotEmpty ? vendor.serviceCategories.first : 'Service',
                          style: AppTextStyles.label,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Added Status Badge based on Schema
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          vendor.status,
                          style: AppTextStyles.label.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Actions Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Request Quote',
                          style: AppTextStyles.label.copyWith(
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Call', style: AppTextStyles.heading3),
                        const SizedBox(height: 4),
                        Text('WhatsApp', style: AppTextStyles.label),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () => viewModel.toggleFavorite(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.lightGreyBackground,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Heart', style: AppTextStyles.label),
                                SizedBox(width: 4),
                                Icon(Icons.favorite_border, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1CDC0), // Peach color
                        borderRadius: BorderRadius.circular(16),

                        image: const DecorationImage(
                          image: AssetImage('assets/images/s37image3.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 4. Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildTab('About', 0, state.activeTabIndex, viewModel),
                  _buildTab('Services', 1, state.activeTabIndex, viewModel),
                  _buildTab('Portfolio', 2, state.activeTabIndex, viewModel),
                  _buildTab('Reviews', 3, state.activeTabIndex, viewModel),
                  _buildTab('Availability', 4, state.activeTabIndex, viewModel),
                ],
              ),
            ),
            const Divider(color: AppColors.dividerColor, height: 1),
            const SizedBox(height: 24),

            // 5. About Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('About', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  const Text(
                    'Cuisine Catering is a premier catering service specializing in creating unforgettable culinary experiences for weddings, corporate events, and private parties. With a focus on fresh, locally-sourced ingredients and innovative menu designs, we tailor each event to reflect your unique style and preferences. Our experienced team ensures seamless execution, from initial consultation to flawless service, leaving you and your guests delighted.',
                    style: AppTextStyles.bodyText,
                    strutStyle: StrutStyle(height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Stats List
                  _buildStatRow('Established', '2010'), // Mock constant
                  const SizedBox(height: 12),
                  _buildStatRow('Team Size', '25+'), // Mock constant
                  const SizedBox(height: 12),
                  // Added Business Stats based on Schema
                  _buildStatRow('Total Bookings', '${vendor.totalBookings}'),
                  const SizedBox(height: 12),
                  _buildStatRow('Completed Bookings', '${vendor.completedBookings}'),
                  const SizedBox(height: 24),

                  // Service Areas
                  const Text('Service Areas', style: AppTextStyles.heading3),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildChip('Los Angeles'),
                      _buildChip('Orange County'),
                      _buildChip('Santa Barbara'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Certifications
                  const Text('Certifications', style: AppTextStyles.heading3),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: vendor.verificationBadges.map((badge) => _buildChip(badge)).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Contact Information
                  const Text(
                    'Contact Information',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: 16),
                  if (vendor.primaryPhone.isNotEmpty) ...[
                    // Primary Phone
                    _buildContactRow(Icons.phone_outlined, vendor.primaryPhone),
                    const SizedBox(height: 16),
                  ],
                  if (vendor.secondaryPhone.isNotEmpty) ...[
                    // Secondary Phone
                    _buildContactRow(Icons.phone_android_outlined, vendor.secondaryPhone),
                    const SizedBox(height: 16),
                  ],
                  if (vendor.businessEmail.isNotEmpty) ...[
                    // Business Email
                    _buildContactRow(Icons.mail_outline, vendor.businessEmail),
                    const SizedBox(height: 16),
                  ],
                  if (vendor.website.isNotEmpty) ...[
                    // Website
                    _buildContactRow(Icons.language, vendor.website),
                    const SizedBox(height: 16),
                  ],
                  if (vendor.addressStreet.isNotEmpty || vendor.addressCity.isNotEmpty) ...[
                    // Address
                    _buildContactRow(Icons.location_on_outlined, '${vendor.addressStreet}, ${vendor.addressCity}'),
                    const SizedBox(height: 32),
                  ],

                  // Bottom Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF88C9E8,
                        ), // Light blue prominent
                        foregroundColor: AppColors.darkText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      icon: SvgPicture.asset(
                        'assets/images/s32icon5share.svg',
                        colorFilter: const ColorFilter.mode(
                          AppColors.darkText,
                          BlendMode.srcIn,
                        ),
                        width: 36,
                        height: 36,
                      ),
                      label: Text(
                        'Share Vendor Profile',
                        style: AppTextStyles.bodyText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
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
    );
  }

  Widget _buildTab(String title, int index, int activeIndex, VendorProfileViewModel viewModel) {
    bool isActive = index == activeIndex;
    return InkWell(
      onTap: () => viewModel.setTab(index),
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.darkText : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: AppTextStyles.bodyText.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.label.copyWith(color: AppColors.lightText),
        ), // Using green tone like image
        Text(
          value,
          style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(color: AppColors.darkText),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.lightGreyBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.darkText, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              text,
              style: AppTextStyles.bodyText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
