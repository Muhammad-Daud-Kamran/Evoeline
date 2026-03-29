import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import '../models/event_model.dart';
import '../viewmodels/event_details_viewmodel.dart';

/// Screen 41: Event Details (MVVM Architecture)
class Screen41EventDetails extends ConsumerStatefulWidget {
  const Screen41EventDetails({super.key});

  @override
  ConsumerState<Screen41EventDetails> createState() =>
      _Screen41EventDetailsState();
}

class _Screen41EventDetailsState extends ConsumerState<Screen41EventDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // Keep local tab controller in sync with ViewModel if needed
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref
            .read(eventDetailsProvider.notifier)
            .setTabIndex(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getPriceText(EventModel event) {
    if (event.isFree) return 'Free';
    if (event.tiers.isNotEmpty) {
      return '\$${event.tiers.first.price.toStringAsFixed(2)}';
    }
    return 'Paid';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventDetailsProvider);

    if (state.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    if (state.errorMessage.isNotEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text(
            state.errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    final event = state.event;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Custom Hero Header
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: AppColors.heroPlaceholderDark,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/images/s32icon5share.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  width: 42,
                  height: 42,
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      event.bannerImage.isNotEmpty
                          ? event.bannerImage
                          : 'assets/images/s41image1.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category, Event Title & Organizer
                  Text(
                    event.category.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.primaryGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'By ${event.organizerName}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.lightText,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Event Schedule & Location (Essential Info)
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.iconColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${event.startDate} • ${event.startTime} - ${event.endTime}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.darkText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.iconColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        event.venueName,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.darkText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons & Pricing
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.darkText,
                            backgroundColor: AppColors.lightGreyBackground,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          text: 'Register - ${_getPriceText(event)}',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Sticky Tab Bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primaryGreen,
                labelColor: AppColors.darkText,
                unselectedLabelColor: AppColors.lightText,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                ),
                tabs: const [
                  Tab(text: 'About'),
                  Tab(text: 'Agenda'),
                  Tab(text: 'Speakers'),
                  Tab(text: 'Venue'),
                ],
              ),
            ),
          ),

          // Tab Views
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(event, state.similarEvents),
                const Center(child: Text('Agenda Content')),
                const Center(child: Text('Speakers Content')),
                const Center(child: Text('Venue Content')),
              ],
            ),
          ),
        ],
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
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 46,
              height: 46,
            ),
            SvgPicture.asset(
              'assets/images/s40iconexplore.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s41iconeventbold.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.primaryGreen, // Active color
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

  /// Builds the "About" tab content using dynamic data
  Widget _buildAboutTab(EventModel event, List<EventModel> similarEvents) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('About'),
          const SizedBox(height: 8),
          Text(
            event.description,
            style: const TextStyle(
              height: 1.5,
              color: AppColors.darkText,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionHeader('What You\'ll Learn'),
          const SizedBox(height: 8),
          // Hardcoded dummy requirements as they aren't in the DB schema for pure display
          _buildChecklistItem('Emerging Technologies'),
          _buildChecklistItem('Industry Best Practices'),
          _buildChecklistItem('Networking Strategies'),
          const SizedBox(height: 24),

          _buildSectionHeader('Who Should Attend'),
          const SizedBox(height: 8),
          Row(children: [_buildAvatarPile(), const SizedBox(width: 12)]),
          const SizedBox(height: 8),
          const Text(
            'Tech professionals, entrepreneurs, and students interested in the latest tech trends.',
            style: TextStyle(
              height: 1.5,
              color: AppColors.darkText,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionHeader('Requirements'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildRequirementCard(Icons.laptop_chromebook, 'Laptop'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildRequirementCard(
                  Icons.settings_suggest,
                  'Basic Tech\nKnowledge',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildSectionHeader('Event Organizer'),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.heroPlaceholderDark,
                backgroundImage: AssetImage('assets/images/s41image2.jpg'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Organizer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    event.organizerName,
                    style: const TextStyle(
                      color: AppColors.lightText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: AppColors.lightGreyBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: const Text(
                'Contact Organizer',
                style: TextStyle(
                  color: AppColors.darkText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionHeader('You Might Also Like'),
          const SizedBox(height: 12),
          _buildSimilarEventsList(similarEvents),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.darkText,
      ),
    );
  }

  Widget _buildChecklistItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.dividerColor),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(color: AppColors.darkText, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPile() {
    return SizedBox(
      width: 80,
      height: 36,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.avatarGreen1,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
          Positioned(
            left: 24,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.avatarGreen2,
                child: const Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ),
          ),
          Positioned(
            left: 48,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.avatarGrey,
                child: const Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementCard(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.iconColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppColors.darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarEventsList(List<EventModel> similarEvents) {
    if (similarEvents.isEmpty) {
      return const Text(
        'No similar events found.',
        style: TextStyle(color: AppColors.lightText),
      );
    }
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: similarEvents.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final event = similarEvents[index];
          return SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(event.bannerImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  event.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  event.startDate,
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

/// Helper delegate for sticky tab bar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.background, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
