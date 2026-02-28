import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/info_chip.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/stat_card_with_image.dart';

/// Screen 25: Event Details
class Screen25EventDetails extends StatelessWidget {
  const Screen25EventDetails({Key? key}) : super(key: key);

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
        title: const Text('Event Details', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Banners (Placeholder for image sequence)
            // TODO: If you have a banner image, replace the Container below with:
            // Image.asset('assets/images/banner.png', width: double.infinity, height: 140, fit: BoxFit.cover),
            Container(
              height: 140,
              width: double.infinity,
              color: AppColors.lightGreyBackground,
              child: Center(
                child:Image.asset('assets/images/banner1screen25.jpg', width: double.infinity, height: 160, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tech Conference 2024',
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Technology | San Francisco',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 16),

                  // Tags/Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      InfoChip(label: 'July 15, 2024'),
                      InfoChip(label: '9:00 AM - 5:00 PM'),
                      InfoChip(label: 'Moscone Center'),
                      InfoChip(label: 'Published'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tabs
                  const CustomTabBar(
                    tabs: ['Overview', 'Attendees', 'Agenda', 'Vendors'],
                    activeIndex: 0,
                  ),
                  const SizedBox(height: 24),

                  // Main Content Image Placeholder
                  // TODO: To add the main content UI image here:
                  // Image.asset('assets/images/circuit.png', width: double.infinity, height: 180, fit: BoxFit.cover),
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyBackground,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child:  Center(
                      child: Image.asset('assets/images/banner2screen25.jpg', width: double.infinity, height: 180, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Statistics Cards
                  Row(
                    children: const [
                      Expanded(
                        child: StatCardWithImage(
                          title: 'Total Registrations',
                          value: '500',
                          icon: Icons.bar_chart,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: StatCardWithImage(
                          title: 'Checked-in Attendees',
                          value: '350',
                          icon: Icons.person_outline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.people_outline,
                            color: AppColors.darkText,
                          ),
                          label: const Text(
                            'Manage\nAttendees',
                            style: AppTextStyles.bodyText,
                            textAlign: TextAlign.center,
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(
                              color: AppColors.dividerColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.workspace_premium_outlined,
                            color: AppColors.darkText,
                          ),
                          label: const Text(
                            'View\nCertificates',
                            style: AppTextStyles.bodyText,
                            textAlign: TextAlign.center,
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(
                              color: AppColors.dividerColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      // Floating '+' Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(
          0xFF00E676,
        ), // Bright green variant from Image 3
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
