import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/overview_stat_card.dart';
import '../widgets/info_list_tile.dart';

/// Screen 26: Event Overview
class Screen26EventOverview extends StatelessWidget {
  const Screen26EventOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Event Overview', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Header Placeholder
            // TODO: Ensure you add a building header image to assets/images.
            // e.g., Replace this Stack/Container with:
            // Stack(children: [
            //   Image.asset('assets/images/building.jpg', height: 200, width: double.infinity, fit: BoxFit.cover),
            //   ...
            // ])
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.iconColor,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 26,
                    left: 16,
                    child: Text(
                      'Tech Summit 2024',
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Image.asset('assets/images/screen26image1.jpg', height: 200, width: double.infinity, fit: BoxFit.cover),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stat Cards Grid
                  Row(
                    children: const [
                      Expanded(
                        child: OverviewStatCard(
                          title: 'Total Registered',
                          value: '2,450',
                          percentage: '+10%',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: OverviewStatCard(
                          title: 'Checked In',
                          value: '1,875',
                          percentage: '+5%',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(
                        child: OverviewStatCard(
                          title: 'Certificates Issued',
                          value: '1,500',
                          percentage: '+8%',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: OverviewStatCard(
                          title: 'Budget Status',
                          value: '\$15,000 / \$20,000',
                          percentage: '+75%',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Progress Bar for Budget
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: AppColors.dividerColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.darkText,
                      ),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Key Information
                  const Text('Key Information', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  const InfoListTile(
                    icon: Icons.person_outline,
                    title: 'Organizer',
                    subtitle: 'Tech Innovators Inc.',
                  ),
                  const InfoListTile(
                    icon: Icons.group_outlined,
                    title: 'Co-Organizers',
                    subtitle: 'Sarah Chen, David Lee',
                  ),
                  const InfoListTile(
                    icon: Icons.campaign_outlined,
                    title: 'Sponsors',
                    subtitle: 'Innovate Solutions, FutureTech',
                  ),
                  const InfoListTile(
                    icon: Icons.handshake_outlined,
                    title: 'Partners',
                    subtitle: 'Global Partners Network',
                  ),
                  const SizedBox(height: 24),

                  // Important Dates
                  const Text('Important Dates', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  const InfoListTile(
                    icon: Icons.calendar_month_outlined,
                    title: 'Registration Opens',
                    subtitle: 'July 15, 2024',
                  ),
                  const InfoListTile(
                    icon: Icons.event_outlined,
                    title: 'Event Dates',
                    subtitle: 'August 20-22, 2024',
                  ),
                  const SizedBox(height: 32),

                  // Buttons
                  CustomButton(
                    text: 'View Public Page',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor: AppColors.darkText,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Share Event',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor: AppColors.darkText,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Edit Details',
                    backgroundColor: AppColors.primaryGreen,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
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
              // HOW TO USE CUSTOM SVG ICONS:
              // 1. Place your .svg file in 'assets/images/' folder (or any folder declared in pubspec.yaml)
              // 2. Use SvgPicture.asset('assets/images/your_icon.svg')
              // 3. Example commented out below:

              /*
            SvgPicture.asset(
              'assets/images/home_icon.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 28,
            ),
            */

              SvgPicture.asset(
                'assets/images/screen26overviewicon.svg',
                colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                width: 44,
                height: 44,
              ),
              SvgPicture.asset(
                'assets/images/s26 attendeeicon.svg',
                colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                width: 44,
                height: 44,
              ),

                SvgPicture.asset(
                  'assets/images/s26scheduleicon.svg',
                  colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                  width: 44,
                  height: 44,
                ),

              SvgPicture.asset(
                'assets/images/s26promoteicon.svg',
                colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                width: 44,
                height: 44,
              ),
              SvgPicture.asset(
                'assets/images/s26settingsicon.svg',
                colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
                width: 44,
                height: 44,
              ),
            ],
          ),
        ),
          // Assuming 'Overview' maps to first tab
    );
  }
}
