import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Screen7Profile extends StatelessWidget {
  const Screen7Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Profile', style: AppTextStyles.heading2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.darkText,
            ),
            onPressed: () => context.pushNamed('settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            // Avatar
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(
                    0xFFFBE9E7,
                  ), // Light peach background for the avatar
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: AppColors.iconColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Sophia Carter', style: AppTextStyles.heading1),
            const SizedBox(height: 4),
            const Text('Event Coordinator', style: AppTextStyles.subtitle),
            const Text(
              'LinkedIn',
              style: TextStyle(color: AppColors.primaryGreen, fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Top Stats (Organized, Attended)
            Row(
              children: [
                Expanded(child: _buildStatContainer('Events Organized', '12')),
                const SizedBox(width: 16),
                Expanded(child: _buildStatContainer('Events Attended', '35')),
              ],
            ),
            const SizedBox(height: 16),

            // Bottom Stat (Certificates Earned)
            _buildStatContainer(
              'Certificates Earned',
              '5',
              width: double.infinity,
            ),
            const SizedBox(height: 24),

            // Quick Actions
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Quick Actions', style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionChip(
                    'Edit Profile',
                    onTap: () => context.pushNamed('editProfile'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionChip(
                    'Settings',
                    onTap: () => context.pushNamed('settings'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildActionChip(
              'Certificates',
              icon: Icons.description_outlined,
              width: double.infinity,
              onTap: () => context.pushNamed('myCertificates'),
            ),
            const SizedBox(height: 24),

            // Recent Activity
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Recent Activity', style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              Icons.calendar_today,
              'You attended Leadership Summit',
              '2024-07-15',
            ),
            _buildActivityItem(
              Icons.workspace_premium_outlined,
              'Certificate issued for Tech',
              '2024-05-20',
            ),
            _buildActivityItem(
              Icons.calendar_today,
              'You attended Marketing Masterclass',
              '2024-03-10',
            ),
            const SizedBox(height: 24),

            // Achievements / Badges
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Achievements / Badges',
                style: AppTextStyles.heading2,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildBadgeItem(
                    'First Event\nOrganized',
                    Icons.assignment_turned_in_outlined,
                    const Color(0xFFE0F2F1),
                    iconColor: AppColors.primaryGreen,
                  ),
                  const SizedBox(width: 16),
                  _buildBadgeItem(
                    '100 Attendees\nMilestone',
                    Icons.assignment,
                    const Color(0xFF00897B),
                    iconColor: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  _buildBadgeItem(
                    'Blockchain',
                    Icons.lock_outline,
                    const Color(0xFFF5F5F5),
                    iconColor: AppColors.iconColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Profile selected
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.lightText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        elevation: 10,
        backgroundColor: AppColors.background,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed('dashboard');
              break;
            case 1:
              context.goNamed('myEvents');
              break;
            case 2:
              // Currently on Profile, do nothing
              break;
            case 3:
              context.goNamed('notifications');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Events',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }

  Widget _buildStatContainer(String label, String value, {double? width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.analyticsLightGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(
    String label, {
    IconData? icon,
    double? width,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.analyticsLightGreen,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: AppColors.darkText),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(IconData icon, String title, String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.analyticsLightGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.lightText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(
    String title,
    IconData icon,
    Color bgColor, {
    required Color iconColor,
  }) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 36),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}
