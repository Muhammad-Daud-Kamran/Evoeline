import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Screen37VendorProfile extends StatelessWidget {
  const Screen37VendorProfile({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onTap: () => Navigator.pop(context),
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
                        colorFilter: const ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
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
                    child: const CircleAvatar(
                      radius: 36,
                      backgroundColor: Color(0xFFBCAAA4), // Brownish
                      backgroundImage: AssetImage('assets/images/s37image2.jpg'),
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
                  const Text('Cuisine Catering', style: AppTextStyles.heading1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '4.8/5.0 (230 reviews)',
                        style: AppTextStyles.label.copyWith(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text('Catering Service', style: AppTextStyles.label),
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
                        Container(
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
                  _buildTab('About', true),
                  _buildTab('Services', false),
                  _buildTab('Portfolio', false),
                  _buildTab('Reviews', false),
                  _buildTab('Avail...', false),
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
                  _buildStatRow('Established', '2010'),
                  const SizedBox(height: 12),
                  _buildStatRow('Team Size', '25+'),
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
                    children: [
                      _buildChip('Certified Event Planner'),
                      _buildChip('Food Safety Certified'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Contact Information
                  const Text(
                    'Contact Information',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: 16),
                  _buildContactRow(Icons.phone_outlined, '(555) 123-4567'),
                  const SizedBox(height: 16),
                  _buildContactRow(
                    Icons.mail_outline,
                    'info@cuisinecatering.com',
                  ),
                  const SizedBox(height: 16),
                  _buildContactRow(Icons.language, 'www.cuisinecatering.com'),
                  const SizedBox(height: 32),

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

  Widget _buildTab(String title, bool isActive) {
    return Container(
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
        Text(text, style: AppTextStyles.bodyText),
      ],
    );
  }
}
