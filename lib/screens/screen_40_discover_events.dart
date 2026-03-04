import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';

/// Screen 40: Discover Events
class Screen40DiscoverEvents extends StatelessWidget {
  const Screen40DiscoverEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
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
            const SizedBox(height: 32),
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
            SvgPicture.asset(
              'assets/images/s32icon1home.svg',
              colorFilter: const ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
              width: 46,
              height: 46,
            ),
            SvgPicture.asset(
              'assets/images/s40iconexplore.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s40iconfav.svg',
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

  /// App Bar with Title and Notification Icon
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
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
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFEDF2F4), // Light blue-grey tint from design
          borderRadius: BorderRadius.circular(12),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: AppColors.lightText, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: AppColors.lightText),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12),
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
        itemCount: 2,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final List<String> titles = ['Tech Meetup', 'Business Network'];
          final List<String> dates = ['Oct 26, 2024', 'Nov 15, 2024'];
          final List<String> images = [
            'assets/images/s40image1.jpg',
            'assets/images/s40image2.png',
          ];

          return SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  titles[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.darkText,
                  ),
                ),
                Text(
                  dates[index],
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 12,
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
      height: 260,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final List<String> titles = ['Future of Tech', 'Global Business'];
          final List<String> subtitles = ['TechCon', 'BizSummit'];
          final List<String> images = [
            'assets/images/s40image3.jpg',
            'assets/images/s40image4.png',
          ];

          return Container(
            width: 240,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFF0F0F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: AssetImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
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
                      Text(
                        subtitles[index],
                        style: const TextStyle(
                          color: AppColors.lightText,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEDF2F4),
                            foregroundColor: AppColors.darkText,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
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
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFEDF2F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  cat['icon'] as IconData,
                  size: 18,
                  color: AppColors.iconColor,
                ),
                const SizedBox(width: 8),
                Text(
                  cat['label'] as String,
                  style: const TextStyle(
                    fontSize: 14,
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
        'image': 'assets/images/s40image5.jpg',
      },
      {
        'title': 'Startup Pitch Night',
        'time': 'Nov 2, 2024 · 6:00 PM',
        'image': 'assets/images/s40image6.jpg',
      },
      {
        'title': 'Healthcare Innovation',
        'time': 'Nov 10, 2024 · 10:30 AM',
        'image': 'assets/images/s40image7.jpg',
      },
      {
        'title': 'Digital Marketing Workshop',
        'time': 'Nov 18, 2024 · 2:00 PM',
        'image': 'assets/images/s40image8.jpg',
      },
      {
        'title': 'FinTech Conference',
        'time': 'Nov 25, 2024 · 9:00 AM',
        'image': 'assets/images/s40image9.jpg',
      },
      {
        'title': 'Design Thinking Seminar',
        'time': 'Dec 2, 2024 · 1:00 PM',
        'image': 'assets/images/s40image10.jpg',
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
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
          childAspectRatio: 1.1, // Matches grid image style
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(item['image'] as String),
                      fit: BoxFit.cover,
                    ),
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
    final items = [
      {
        'title': 'AI Workshop',
        'date': 'Oct 29, 2024',
        'image': 'assets/images/s40image11.jpg',
      },
      {
        'title': 'Marketing Seminar',
        'date': 'Nov 5, 2024',
        'image': 'assets/images/s40image12.jpg',
      },
    ];

    return SizedBox(
      height: 160,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(item['image'] as String),
                        fit: BoxFit.cover,
                      ),
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
                ),
                Text(
                  item['date'] as String,
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Your Past Events (Horizontal List)
  Widget _buildPastEventsList() {
    final items = [
      {
        'title': 'Past Event 1',
        'date': 'Oct 1, 2024',
        'image': 'assets/images/s40image14.jpg',
      },
      {
        'title': 'Past Event 2',
        'date': 'Oct 8, 2024',
        'image': 'assets/images/s40image15.jpg',
      },
    ];

    return SizedBox(
      height: 160,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(item['image'] as String),
                        fit: BoxFit.cover,
                      ),
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
                ),
                Text(
                  item['date'] as String,
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
