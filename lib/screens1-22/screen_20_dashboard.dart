import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class Screen20Dashboard extends StatelessWidget {
  const Screen20Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic responsive check to simulate the sidebar layout (Tablet/Web style)
    final isDesktop = MediaQuery.of(context).size.width > 800;

    Widget content = SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hello, Anya \uD83D\uDC4B',
                style: AppTextStyles.heading2,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pushNamed('notifications'),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.searchBarFillColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications_none,
                        color: AppColors.darkText,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => context.pushNamed('profile'),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/Screen_20_0.png'),
                      radius: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Here\'s your event overview for today',
            style: AppTextStyles.bodyText,
          ),
          const SizedBox(height: 32),

          // Quick Stats
          const Text('Quick Stats', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Upcoming Events',
                  '3',
                  'assets/images/Screen_20_1.png',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Total Attendees',
                  '150',
                  'assets/images/Screen_20_2.png',
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Upcoming Events Horizontal List
          const Text('Upcoming Events', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildEventCard(
                  'Tech Summit 2024',
                  'July 15, 2024',
                  'assets/images/Screen_20_3.png',
                  () => context.pushNamed('eventDetails'),
                ),
                const SizedBox(width: 16),
                _buildEventCard(
                  'Summer Jam Fest',
                  'August 5, 2024',
                  'assets/images/Screen_20_4.png',
                  () => context.pushNamed('eventDetails'),
                ),
                const SizedBox(width: 16),
                _buildEventCard(
                  'Business Growth Seminar',
                  'September 20, 2024',
                  'assets/images/Screen_20_5.png',
                  () => context.pushNamed('eventDetails'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Recent Activity
          const Text('Recent Activity', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          _buildActivityItem(
            Icons.check,
            'You published \'Tech Summit 2024\'',
            '2 hours ago',
          ),
          _buildActivityItem(
            Icons.edit,
            'You updated \'Summer Jam Fest\'',
            'Yesterday',
          ),
          _buildActivityItem(
            Icons.upload_file,
            'You uploaded documents for \'Business Growth Seminar\'',
            '2 days ago',
          ),
          const SizedBox(height: 32),

          // Quick Actions
          const Text('Quick Actions', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildActionCard(
                  'Discover',
                  'assets/images/Screen_20_9.png',
                  () => context.pushNamed('discover'),
                ),
                const SizedBox(width: 12),
                _buildActionCard(
                  'My Events',
                  'assets/images/Screen_20_6.png',
                  () => context.pushNamed('myEvents'),
                ),
                const SizedBox(width: 12),
                _buildActionCard(
                  'Vendors',
                  'assets/images/Screen_20_7.png',
                  () => context.pushNamed('vendorDirectory'),
                ),
                const SizedBox(width: 12),
                _buildActionCard(
                  'Analytics',
                  'assets/images/Screen_20_8.png',
                  () => context.pushNamed('analytics'),
                ),
                const SizedBox(width: 12),
                _buildActionCard(
                  'Certificates',
                  'assets/images/Screen_20_9.png',
                  () => context.pushNamed('myCertificates'),
                ),
                const SizedBox(width: 12),
                _buildActionCard(
                  'Settings',
                  'assets/images/Screen_20_10.png', // Fallback for last action
                  () => context.pushNamed('settings'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isDesktop
          ? null
          : AppBar(
              title: const Text('EventFlow', style: AppTextStyles.heading3),
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.darkText),
            ),
      drawer: isDesktop ? null : _buildSidebar(context),
      body: Row(
        children: [
          if (isDesktop) SizedBox(width: 250, child: _buildSidebar(context)),
          if (isDesktop)
            const VerticalDivider(width: 1, color: AppColors.dividerColor),
          Expanded(child: content),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('createEventStep1'),
        backgroundColor: AppColors.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.lightGreyBackground,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text('EventFlow', style: AppTextStyles.heading2),
          ),
          _buildSidebarItem('Home', Icons.home, isSelected: true, onTap: () {}),
          _buildSidebarItem(
            'Events',
            Icons.calendar_today,
            onTap: () => context.pushNamed('myEvents'),
          ),
          _buildSidebarItem(
            'Discover',
            Icons.explore,
            onTap: () => context.pushNamed('discover'),
          ),
          _buildSidebarItem(
            'Tasks',
            Icons.check_box_outlined,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task screen not implemented')),
            ),
          ),
          _buildSidebarItem(
            'Profile',
            Icons.person_outline,
            onTap: () => context.pushNamed('profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
    String title,
    IconData icon, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.darkText),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: AppColors.darkText,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 120, // Adjusted height to match mockup proportions
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.lightGreyBackground,
                child: const Icon(
                  Icons.insert_chart_outlined,
                  color: AppColors.darkText,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryGreen,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(
    String title,
    String date,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.darkText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              date,
              style: const TextStyle(color: AppColors.lightText, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(IconData icon, String title, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.darkText, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.darkText,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.lightGreyBackground,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.darkText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
