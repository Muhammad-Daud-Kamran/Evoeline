import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Screen15DiscoverList extends StatefulWidget {
  const Screen15DiscoverList({super.key});

  @override
  State<Screen15DiscoverList> createState() => _Screen15DiscoverListState();
}

class _Screen15DiscoverListState extends State<Screen15DiscoverList> {
  String _selectedCategory = 'All';
  String _selectedSort = 'Relevance';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _allEvents = [
    {
      'title': 'Tech Innovators Summit',
      'details': 'Oct 26, 2024 • San Francisco',
      'price': 'Free',
      'image': 'assets/images/Screen_15_1.png',
      'category': 'Conferences',
      'date': DateTime(2024, 10, 26),
      'popularity': 95,
    },
    {
      'title': 'Design Thinking Workshop',
      'details': 'Nov 15, 2024 • New York',
      'price': '\$25',
      'image': 'assets/images/Screen_15_2.png',
      'category': 'Workshops',
      'date': DateTime(2024, 11, 15),
      'popularity': 80,
    },
    {
      'title': 'AI and Machine Learning Conference',
      'details': 'Dec 5, 2024 • Boston',
      'price': '\$50',
      'image': 'assets/images/Screen_15_3.png',
      'category': 'Conferences',
      'date': DateTime(2024, 12, 5),
      'popularity': 90,
    },
    {
      'title': 'JavaScript Developers Meetup',
      'details': 'Oct 30, 2024 • Austin',
      'price': 'Free',
      'image': 'assets/images/Screen_15_1.png',
      'category': 'Meetups',
      'date': DateTime(2024, 10, 30),
      'popularity': 75,
    },
  ];

  List<Map<String, dynamic>> get _filteredEvents {
    List<Map<String, dynamic>> filtered = _allEvents.where((event) {
      final matchesSearch = event['title']
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          event['details'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || event['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    if (_selectedSort == 'Date') {
      filtered.sort((a, b) => (a['date'] as DateTime).compareTo(b['date']));
    } else if (_selectedSort == 'Popularity') {
      filtered.sort((a, b) =>
          (b['popularity'] as int).compareTo(a['popularity'] as int));
    }

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Discover', style: AppTextStyles.heading2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.darkText),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Filter settings'))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Search Bar
            Container(
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
                      controller: _searchController,
                      onChanged: (value) => setState(() => _searchQuery = value),
                      decoration: const InputDecoration(
                        hintText: 'Search events, speakers, or keywords',
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

            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', isSelected: _selectedCategory == 'All'),
                  _buildFilterChip('Conferences',
                      isSelected: _selectedCategory == 'Conferences'),
                  _buildFilterChip('Workshops',
                      isSelected: _selectedCategory == 'Workshops'),
                  _buildFilterChip('Meetups',
                      isSelected: _selectedCategory == 'Meetups'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Sort By
            const Text('Sort by', style: AppTextStyles.heading3),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildSortChip('Relevance',
                    isSelected: _selectedSort == 'Relevance'),
                _buildSortChip('Date', isSelected: _selectedSort == 'Date'),
                _buildSortChip('Popularity',
                    isSelected: _selectedSort == 'Popularity'),
              ],
            ),
            const SizedBox(height: 24),

            ..._filteredEvents.map((event) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildEventCard(
                    event['title'],
                    event['details'],
                    event['price'],
                    event['image'],
                    context,
                  ),
                )),

            if (_filteredEvents.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    'No events found match your search.',
                    style: AppTextStyles.subtitle,
                  ),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Discover selected
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
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed('discoverList');
              break;
            case 1:
              context.goNamed('myEvents');
              break;
            case 2:
              context.goNamed('myCertificates');
              break;
            case 3:
              context.goNamed('profile');
              break;
          }
        },
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

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () => setState(() => _selectedCategory = label),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.analyticsLightGreen
                : AppColors.lightGreyBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
              color: AppColors.darkText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSortChip(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () => setState(() => _selectedSort = label),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.analyticsLightGreen
                : AppColors.lightGreyBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.primaryGreen : Colors.transparent,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
              color: AppColors.darkText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(
    String title,
    String details,
    String price,
    String imagePath,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () => context.pushNamed('eventDetails'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 12,
                  ),
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
                  details,
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => context.pushNamed('register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.analyticsLightGreen,
                    foregroundColor: AppColors.darkText,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 130,
            height: 130,
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
