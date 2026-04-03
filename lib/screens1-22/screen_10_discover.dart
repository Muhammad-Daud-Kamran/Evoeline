import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/discover_bottom_nav_bar.dart';

class Screen10Discover extends StatelessWidget {
  const Screen10Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.darkText),
          onPressed: () => ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Menu toggled'))),
        ),
        title: const Text('EventFlow', style: AppTextStyles.heading2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.darkText,
            ),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Notifications'))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Welcome back, Anya \uD83D\uDC4B',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: 8),
            const Text(
              'Find upcoming events, explore new ones, and manage your certificates.',
              style: AppTextStyles.bodyText,
            ),
            const SizedBox(height: 24),

            // Search Bar
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.searchBarFillColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: AppColors.iconColor),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search events, keywords, or speakers',
                        hintStyle: TextStyle(
                          color: AppColors.lightText,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Chips
            Row(
              children: [
                _buildFilterChip('Type'),
                const SizedBox(width: 8),
                _buildFilterChip('Date'),
                const SizedBox(width: 8),
                _buildFilterChip('Location'),
              ],
            ),
            const SizedBox(height: 24),

            // Featured Events
            const Text('Featured Events', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFeaturedCard(
                    'Tech Summit 2024',
                    'Featured',
                    const Color(0xFFB2DFDB),
                  ), // Example color
                  const SizedBox(width: 16),
                  _buildFeaturedCard(
                    'Design Thinking Workshop',
                    'Popular',
                    const Color(0xFF388E3C),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Your Registered Events
            const Text('Your Registered Events', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            _buildRegisteredEventItem(
              'AI in Business Conference',
              '2 days left',
              const Color(0xFFCFD8DC),
            ),
            const SizedBox(height: 12),
            _buildRegisteredEventItem(
              'Digital Marketing Workshop',
              'No Certificate',
              const Color(0xFF3E2723),
            ),
            const SizedBox(height: 12),
            _buildRegisteredEventItem(
              'Leadership Seminar',
              'Pending',
              const Color(0xFF37474F),
            ),

            const SizedBox(height: 24),

            // My Certificates
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'My Certificates',
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'You\'ve earned 4 certificates',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.analyticsLightGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCCBC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.description_outlined,
                      size: 40,
                      color: AppColors.darkText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recommended for You
            const Text('Recommended for You', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildRecommendedCard(
                    'Future of Tech',
                    'Tech',
                    const Color(0xFF263238),
                  ),
                  const SizedBox(width: 16),
                  _buildRecommendedCard(
                    'Marketing Trends',
                    'Marketing',
                    const Color(0xFF00695C),
                  ),
                  const SizedBox(width: 16),
                  _buildRecommendedCard(
                    'Design Systems',
                    'Design',
                    const Color(0xFF8D6E63),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: const DiscoverBottomNavBar(),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.analyticsLightGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.darkText,
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(String title, String subtitle, Color bgColor) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(height: 80), // Image placeholder
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkText,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.primaryGreen, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisteredEventItem(
    String title,
    String status,
    Color imageColor,
  ) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: imageColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.darkText,
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward, color: AppColors.iconColor, size: 20),
      ],
    );
  }

  Widget _buildRecommendedCard(String title, String category, Color bgColor) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(height: 40), // Image placeholder
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Text(
            category,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
