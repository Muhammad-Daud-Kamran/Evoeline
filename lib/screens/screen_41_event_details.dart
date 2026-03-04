import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';

/// Screen 41: Event Details
class Screen41EventDetails extends StatefulWidget {
  const Screen41EventDetails({super.key});

  @override
  State<Screen41EventDetails> createState() => _Screen41EventDetailsState();
}

class _Screen41EventDetailsState extends State<Screen41EventDetails>
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
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 42,
                  height: 42,
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/s41image1.jpg'),
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
                  // Event Title & Organizer
                  const Text(
                    'Tech Summit 2024',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'By Innovate Events',
                    style: TextStyle(fontSize: 14, color: AppColors.lightText),
                  ),
                  const SizedBox(height: 16),

                  // Action Buttons
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
                        child: CustomButton(text: 'Register', onPressed: () {}),
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
                _buildAboutTab(),
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
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
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
              'assets/images/s41iconeventbold.svg',
              colorFilter: const ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
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

  /// Builds the "About" tab content
  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('About'),
          const SizedBox(height: 8),
          const Text(
            'Join us for Tech Summit 2024, a premier event for tech enthusiasts and professionals. Explore the latest trends, network with industry leaders, and gain insights into the future of technology.',
            style: TextStyle(
              height: 1.5,
              color: AppColors.darkText,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionHeader('What You\'ll Learn'),
          const SizedBox(height: 8),
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
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.heroPlaceholderDark,
                backgroundImage: const AssetImage('assets/images/s41image2.jpg'),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Organizer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Innovate Events',
                    style: TextStyle(color: AppColors.lightText, fontSize: 12),
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
          _buildSimilarEventsList(),
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

  Widget _buildSimilarEventsList() {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final titles = [
            'AI in Business',
            'Design Thinking Workshop',
            'Sustainable Energy Expo',
            'Cybersecurity Summit',
          ];
          final dates = ['Oct 15', 'Nov 5', 'Nov 20', 'Dec 12'];
          final images = [
            'assets/images/s40image6.jpg',
            'assets/images/s40image11.jpg',
            'assets/images/s41image3.jpg', // Added
            'assets/images/s41image4.jpg', // Added
          ];
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
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  titles[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  dates[index],
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
