import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../viewmodels/discover_events_viewmodel.dart';
import '../models/event_model.dart';

/// Screen 40: Discover Events (MVVM Architecture)
class Screen40DiscoverEvents extends ConsumerWidget {
  const Screen40DiscoverEvents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(discoverEventsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            )
          : state.errorMessage.isNotEmpty
          ? Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildSearchBar(ref, state.searchQuery),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Events Near You'),
                  const SizedBox(height: 12),
                  _buildEventsNearYouList(state.eventsNearYou),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Trending Now'),
                  const SizedBox(height: 12),
                  _buildTrendingNowList(state.trendingEvents),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Browse by Category'),
                  const SizedBox(height: 12),
                  _buildCategoryChips(ref, state.selectedCategory),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Upcoming Events'),
                  const SizedBox(height: 12),
                  _buildUpcomingEventsGrid(state.upcomingEvents),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Recommended for You'),
                  const SizedBox(height: 12),
                  _buildRecommendedList(state.recommendedEvents),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Your Past Events'),
                  const SizedBox(height: 12),
                  _buildPastEventsList(state.pastEvents),
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
              colorFilter: const ColorFilter.mode(
                AppColors.darkText,
                BlendMode.srcIn,
              ),
              width: 46,
              height: 46,
            ),
            SvgPicture.asset(
              'assets/images/s40iconexplore.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.primaryGreen, // Highlighted active icon
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s40iconfav.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s32icon4profile.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
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

  /// Search Bar integrated with ViewModel
  Widget _buildSearchBar(WidgetRef ref, String currentQuery) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFEDF2F4), // Light blue-grey tint from design
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          onChanged: (val) =>
              ref.read(discoverEventsProvider.notifier).setSearchQuery(val),
          decoration: const InputDecoration(
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

  /// Get formatted price string out of an EventModel
  String _getPriceText(EventModel event) {
    if (event.isFree) return 'Free';
    if (event.tiers.isNotEmpty) {
      return '\$${event.tiers.first.price.toStringAsFixed(2)}';
    }
    return 'Paid';
  }

  /// Horizontal list of Events Near You
  Widget _buildEventsNearYouList(List<EventModel> events) {
    if (events.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'No events found near you.',
          style: TextStyle(color: AppColors.lightText),
        ),
      );
    }

    return SizedBox(
      height: 260,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final event = events[index];
          return SizedBox(
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(event.bannerImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  event.category.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.title,
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
                  event.description,
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.startDate,
                      style: const TextStyle(
                        color: AppColors.lightText,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _getPriceText(event),
                      style: const TextStyle(
                        color: AppColors.darkText,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Trending Now Horizontal List
  Widget _buildTrendingNowList(List<EventModel> events) {
    if (events.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'No trending events at the moment.',
          style: TextStyle(color: AppColors.lightText),
        ),
      );
    }

    return SizedBox(
      height: 310,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final event = events[index];
          return Container(
            width: 260,
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
                        image: AssetImage(event.bannerImage),
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
                        event.category.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        event.title,
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
                        event.description,
                        style: const TextStyle(
                          color: AppColors.lightText,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getPriceText(event),
                            style: const TextStyle(
                              color: AppColors.darkText,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 36,
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
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
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

  /// Horizontal category chips linked to ViewModel
  Widget _buildCategoryChips(WidgetRef ref, String selectedCategory) {
    final categories = [
      {'icon': Icons.computer, 'label': 'Technology'},
      {'icon': Icons.business_center, 'label': 'Business'},
      {'icon': Icons.school, 'label': 'Health'}, // Updated to match dummy data
      {'icon': Icons.campaign, 'label': 'Marketing'},
      {'icon': Icons.account_balance, 'label': 'Finance'},
      {'icon': Icons.brush, 'label': 'Design'},
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
          final isSelected = selectedCategory == cat['label'];

          return GestureDetector(
            onTap: () {
              ref
                  .read(discoverEventsProvider.notifier)
                  .setSelectedCategory(cat['label'] as String);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryGreen
                    : const Color(0xFFEDF2F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    cat['icon'] as IconData,
                    size: 18,
                    color: isSelected ? Colors.white : AppColors.iconColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    cat['label'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.darkText,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Grid view for Upcoming Events (Filters applied here dynamically by ViewModel)
  Widget _buildUpcomingEventsGrid(List<EventModel> events) {
    if (events.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'No upcoming events found for this category or search.',
          style: TextStyle(color: AppColors.lightText),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: events.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
          childAspectRatio: 0.60,
        ),
        itemBuilder: (context, index) {
          final event = events[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(event.bannerImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                event.category.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                event.title,
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
                event.description,
                style: const TextStyle(
                  color: AppColors.lightText,
                  fontSize: 11,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.startDate,
                    style: const TextStyle(
                      color: AppColors.lightText,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _getPriceText(event),
                    style: const TextStyle(
                      color: AppColors.darkText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  /// Recommended for You (Horizontal List)
  Widget _buildRecommendedList(List<EventModel> events) {
    if (events.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final event = events[index];
          return SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(event.bannerImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  event.category.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.description,
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.startDate,
                      style: const TextStyle(
                        color: AppColors.lightText,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _getPriceText(event),
                      style: const TextStyle(
                        color: AppColors.darkText,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Your Past Events (Horizontal List)
  Widget _buildPastEventsList(List<EventModel> events) {
    if (events.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'You have no past events.',
          style: TextStyle(color: AppColors.lightText),
        ),
      );
    }
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final event = events[index];
          return SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(event.bannerImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  event.category.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.description,
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.startDate,
                      style: const TextStyle(
                        color: AppColors.lightText,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _getPriceText(event),
                      style: const TextStyle(
                        color: AppColors.darkText,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
