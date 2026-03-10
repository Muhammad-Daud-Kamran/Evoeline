import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Screen18Notifications extends StatefulWidget {
  const Screen18Notifications({super.key});

  @override
  State<Screen18Notifications> createState() => _Screen18NotificationsState();
}

class _Screen18NotificationsState extends State<Screen18Notifications>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Notifications', style: AppTextStyles.heading2),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Clear All',
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.darkText,
            unselectedLabelColor: AppColors.primaryGreen,
            indicatorColor: AppColors.darkText,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Unread'),
              Tab(text: 'Tasks'),
              Tab(text: 'Events'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationsList(),
          _buildNotificationsList(), // Placeholder
          _buildNotificationsList(), // Placeholder
          _buildNotificationsList(), // Placeholder
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            0, // Assuming this is accessed somewhere else typically, keeping basic structure
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
        backgroundColor: Colors.white,
        onTap: (_) {},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'My Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium_outlined),
            label: 'Certificates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: [
        _buildNotificationItem(
          Icons.insert_drive_file_outlined,
          'Application Received',
          'Your application for the \'Tech Innovators Summit\' has been',
          '2h ago',
        ),
        _buildNotificationItem(
          Icons.calendar_today_outlined,
          'Event Update',
          'The \'Digital Marketing Masterclass\' event has been updated with new',
          '4h ago',
        ),
        _buildNotificationItem(
          Icons.check_box_outlined,
          'New Task Assigned',
          'You have a new task assigned for the \'Product Launch Workshop\'.',
          '6h ago',
        ),
        _buildNotificationItem(
          Icons.workspace_premium_outlined,
          'Certificate Available',
          'Your certificate for the \'Data Science Bootcamp\' is now',
          '8h ago',
        ),
        _buildNotificationItem(
          Icons.event_available_outlined,
          'Event Rescheduled',
          'The \'AI in Business Conference\' has been rescheduled to next',
          '10h ago',
        ),
        _buildNotificationItem(
          Icons.campaign_outlined,
          'Feedback Requested',
          'Your feedback is requested for the \'Design Thinking Workshop\'.',
          '12h ago',
        ),
      ],
    );
  }

  Widget _buildNotificationItem(
    IconData icon,
    String title,
    String description,
    String time,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.searchBarFillColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.darkText, size: 24),
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
                    fontSize: 15,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            time,
            style: const TextStyle(color: AppColors.primaryGreen, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
