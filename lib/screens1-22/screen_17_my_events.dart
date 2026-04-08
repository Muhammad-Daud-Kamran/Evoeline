import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Screen17MyEvents extends StatefulWidget {
  const Screen17MyEvents({super.key});

  @override
  State<Screen17MyEvents> createState() => _Screen17MyEventsState();
}

class _Screen17MyEventsState extends State<Screen17MyEvents>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('My Events', style: AppTextStyles.heading2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.darkText),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Menu tapped'))),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.darkText,
            unselectedLabelColor: AppColors.lightText,
            indicatorColor: AppColors.primaryGreen,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEventsList(),
          _buildEventsList(), // Placeholder
          _buildEventsList(), // Placeholder
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('createEventStep1'),
        backgroundColor: AppColors.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEventsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      hintText: 'Search your events',
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

          // Date Filter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Date', style: AppTextStyles.bodyText),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.darkText),
            ],
          ),
          const SizedBox(height: 24),

          // Event List
          _buildEventItem(
            'Live',
            'Tech Summit 2024',
            'Jul 20, 2024 • 9:00 AM',
            AppColors.primaryGreen,
            'assets/images/Screen_17_1.png',
          ),
          const SizedBox(height: 24),
          _buildEventItem(
            'Upcoming',
            'Music Festival',
            'Aug 15, 2024 • 12:00 PM',
            AppColors.primaryGreen,
            'assets/images/Screen_17_2.png',
          ),
          const SizedBox(height: 24),
          _buildEventItem(
            'Draft',
            'Art Exhibition',
            'Sep 5, 2024 • 10:00 AM',
            AppColors.primaryGreen,
            'assets/images/Screen_17_4.png',
          ),
          const SizedBox(height: 24),
          _buildEventItem(
            'Completed',
            'Food Fair',
            'Jun 10, 2024 • 11:00 AM',
            AppColors.primaryGreen,
            'assets/images/Screen_17_3.png',
          ),
          const SizedBox(height: 80), // To avoid FAB overlapping
        ],
      ),
    );
  }

  Widget _buildEventItem(
    String status,
    String title,
    String date,
    Color statusColor,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () => context.pushNamed('eventOverview'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(color: statusColor, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.searchBarFillColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Actions',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.more_horiz, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 130,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
