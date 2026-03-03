import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/discover_bottom_nav_bar.dart';

/// Screen 40: Discover Events
class Screen40DiscoverEvents extends StatelessWidget {
  const Screen40DiscoverEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildSectionTitle('Events Near You'),
            const SizedBox(height: 12),
            _buildEventsNearYouList(),
            const SizedBox(height: 24),
            _buildSectionTitle('Trending Now'),
            const SizedBox(height: 12),
            _buildTrendingNowList(),
            const SizedBox(height: 24),
            _buildSectionTitle('Browse by Category'),
            const SizedBox(height: 12),
            _buildCategoryChips(),
            const SizedBox(height: 24),
            _buildSectionTitle('Upcoming Events'),
            const SizedBox(height: 12),
            _buildUpcomingEventsGrid(),
            const SizedBox(height: 24),
            _buildSectionTitle('Recommended for You'),
            const SizedBox(height: 12),
            _buildRecommendedList(),
            const SizedBox(height: 24),
            _buildSectionTitle('Your Past Events'),
            const SizedBox(height: 12),
            _buildPastEventsList(),
          ],
        ),
      ),
      bottomNavigationBar: const DiscoverBottomNavBar(currentIndex: 0),
    );
  }

  /// App Bar with Title and Notification Icon
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Discover Events',
        style: TextStyle(
          color: AppColors.darkText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.explore_outlined, color: AppColors.iconColor),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none,
            color: AppColors.iconColor,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  /// Search Bar with custom styling
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.dividerColor),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search events, organizers, categories...',
            hintStyle: TextStyle(color: AppColors.lightText, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: AppColors.lightText),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  /// Reusable Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
      ),
    );
  }

  /// Horizontal list of Events Near You
  Widget _buildEventsNearYouList() {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          // Dummy data for visual representation
          final List<String> titles = [
            'Tech Meetup',
            'Business Network',
            'Art Expo',
          ];
          final List<String> dates = [
            'Oct 26, 2024',
            'Nov 15, 2024',
            'Dec 01, 2024',
          ];

          return Container(
            width: 140,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.dividerColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Placeholder
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.lightGreyBackground,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    // TODO: Replace with actual asset image
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        color: AppColors.lightText,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.darkText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dates[index],
                        style: const TextStyle(
                          color: AppColors.lightText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Trending Now Horizontal List
  Widget _buildTrendingNowList() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final List<String> titles = ['Future of Tech', 'Global Business'];
          final List<String> subtitles = ['TechCon', 'BizSummit'];

          return Container(
            width: 240,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.dividerColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Highlight Image Placeholder
                Container(
                  height: 110,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6B9F9A), // Based on UI image palette
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  // TODO: Use NetworkImage or AssetImage here
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitles[index],
                        style: const TextStyle(
                          color: AppColors.lightText,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightGreyBackground,
                            foregroundColor: AppColors.darkText,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Horizontal category chips
  Widget _buildCategoryChips() {
    final categories = [
      {'icon': Icons.computer, 'label': 'Technology'},
      {'icon': Icons.business_center, 'label': 'Business'},
      {'icon': Icons.school, 'label': 'Education'},
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.dividerColor),
            ),
            child: Row(
              children: [
                Icon(
                  cat['icon'] as IconData,
                  size: 16,
                  color: AppColors.iconColor,
                ),
                const SizedBox(width: 8),
                Text(
                  cat['label'] as String,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Grid view for Upcoming Events
  Widget _buildUpcomingEventsGrid() {
    final items = [
      {
        'title': 'AI in Business',
        'time': 'Oct 28, 2024 · 9:00 AM',
        'color': 0xFF2F4F4F,
      },
      {
        'title': 'Startup Pitch Night',
        'time': 'Nov 2, 2024 · 6:00 PM',
        'color': 0xFF66CDAA,
      },
      {
        'title': 'Healthcare Innovation',
        'time': 'Nov 10, 2024 · 10:00 AM',
        'color': 0xFF001F3F,
      },
      {
        'title': 'Digital Marketing',
        'time': 'Nov 18, 2024 · 2:00 PM',
        'color': 0xFFE0F2F1,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail Placeholder
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(item['color'] as int),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item['title'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.darkText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                item['time'] as String,
                style: const TextStyle(
                  color: AppColors.lightText,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }

  /// Recommended for You (Horizontal List)
  Widget _buildRecommendedList() {
    return _buildSmallHorizontalList(
      colors: [0xFF2A363B, 0xFF769695, 0xFF43A047],
      titles: ['AI Workshop', 'Marketing Seminar', 'Finance 101'],
      dates: ['Oct 29, 2024', 'Nov 5, 2024', 'Nov 12, 2024'],
    );
  }

  /// Your Past Events (Horizontal List)
  Widget _buildPastEventsList() {
    return _buildSmallHorizontalList(
      colors: [0xFFE6E2DB, 0xFF423C32, 0xFF5B6E4A],
      titles: ['Past Event 1', 'Past Event 2', 'Past Event 3'],
      dates: ['Oct 1, 2024', 'Oct 8, 2024', 'Oct 15, 2024'],
    );
  }

  /// Reusable helper for compact horizontal lists (Recommended / Past Events)
  Widget _buildSmallHorizontalList({
    required List<int> colors,
    required List<String> titles,
    required List<String> dates,
  }) {
    return SizedBox(
      height: 130, // Thumbnail + text
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: titles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image container
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(colors[index]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  titles[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.darkText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  dates[index],
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
