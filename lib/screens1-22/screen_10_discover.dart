import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
            onPressed: () => context.pushNamed('notifications'),
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
            GestureDetector(
              onTap: () => context.pushNamed('discoverList'),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.searchBarFillColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.iconColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        onTap: () => context.pushNamed('discoverList'),
                        decoration: const InputDecoration(
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
            ),
            const SizedBox(height: 16),

            // Chips
            Row(
              children: [
                _buildFilterChip('Type', context),
                const SizedBox(width: 8),
                _buildFilterChip('Date', context),
                const SizedBox(width: 8),
                _buildFilterChip('Location', context),
              ],
            ),
            const SizedBox(height: 24),

            // Featured Events
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Featured Events', style: AppTextStyles.heading2),
                TextButton(
                  onPressed: () => context.pushNamed('discoverList'),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFeaturedCard(
                    'Tech Summit 2024',
                    'Featured',
                    'assets/images/Screen_10_1.png',
                    context,
                  ),
                  const SizedBox(width: 16),
                  _buildFeaturedCard(
                    'Design Thinking Workshop',
                    'Popular',
                    'assets/images/Screen_10_2.png',
                    context,
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
              'assets/images/Screen_10_3.png',
              context,
            ),
            const SizedBox(height: 12),
            _buildRegisteredEventItem(
              'Digital Marketing Workshop',
              'No Certificate',
              'assets/images/Screen_10_4.png',
              context,
            ),
            const SizedBox(height: 12),
            _buildRegisteredEventItem(
              'Leadership Seminar',
              'Pending',
              'assets/images/Screen_10_5.png',
              context,
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
                        GestureDetector(
                          onTap: () => context.pushNamed('myCertificates'),
                          child: Container(
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
                    'assets/images/Screen_10_6.png',
                    context,
                  ),
                  const SizedBox(width: 16),
                  _buildRecommendedCard(
                    'Marketing Trends',
                    'Marketing',
                    'assets/images/Screen_10_7.png',
                    context,
                  ),
                  const SizedBox(width: 16),
                  _buildRecommendedCard(
                    'Design Systems',
                    'Design',
                    'assets/images/Screen_10_1.png',
                    context,
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

  Widget _buildFilterChip(String label, BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed('discoverList'),
      child: Container(
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
      ),
    );
  }

  Widget _buildFeaturedCard(String title, String subtitle, String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed('eventDetails'),
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // Light background to ground the card
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.darkText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: AppColors.primaryGreen, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisteredEventItem(
    String title,
    String status,
    String imagePath,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => context.pushNamed('eventOverview'),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
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
      ),
    );
  }

  Widget _buildRecommendedCard(String title, String category, String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed('eventDetails'),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.4),
              BlendMode.darken,
            ),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
      ),
    );
  }
}
