import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/info_chip.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/stat_card_with_image.dart';

/// Screen 25: Event Details (Organizer View)
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
            // Top Banner
            Container(
              height: 140,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/banner1screen25.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tech Summit 2024',
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Technology | Convention Center, NY',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 16),

                  // Tags/Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      InfoChip(label: 'Aug 20, 2024'),
                      InfoChip(label: '9:00 AM - 5:00 PM'),
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

                  // Main Content Graphic
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyBackground,
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/banner2screen25.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // NEW: Capacity & Registration Stats (Schema: capacity)
                  Row(
                    children: const [
                      Expanded(
                        child: StatCardWithImage(
                          title: 'Total Registered',
                          value: '120 / 150',
                          icon: Icons.bar_chart,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: StatCardWithImage(
                          title: 'Remaining Seats',
                          value: '30 Available',
                          icon: Icons.event_seat_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // NEW: Event Description (Schema: description)
                  const Text('About this Event', style: AppTextStyles.heading2),
                  const SizedBox(height: 8),
                  const Text(
                    'A premier tech conference featuring industry leaders, workshops, and networking opportunities. Join us to explore the future of AI, Cloud Computing, and Blockchain technology.',
                    style: AppTextStyles.bodyText,
                  ),
                  const SizedBox(height: 24),

                  // NEW: Tickets & Pricing (Schema: pricing.tiers)
                  const Text('Tickets & Pricing', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  _buildTicketTier('Early Bird', 'PKR 1500', 'Ends Mar 15'),
                  _buildTicketTier('Regular', 'PKR 2000', 'Available'),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.people_outline, color: AppColors.darkText),
                          label: const Text('Manage\nAttendees', style: AppTextStyles.bodyText, textAlign: TextAlign.center),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            side: const BorderSide(color: AppColors.dividerColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.workspace_premium_outlined, color: AppColors.darkText),
                          label: const Text('View\nCertificates', style: AppTextStyles.bodyText, textAlign: TextAlign.center),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            side: const BorderSide(color: AppColors.dividerColor),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00E676),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Helper for Ticket Tiers
  Widget _buildTicketTier(String title, String price, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightGreyBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.heading3),
                Text(subtitle, style: AppTextStyles.label),
              ],
            ),
            Text(price, style: AppTextStyles.heading3.copyWith(color: AppColors.primaryGreen)),
          ],
        ),
      ),
    );
  }
}