import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';

class Screen12MyCertificates extends StatefulWidget {
  const Screen12MyCertificates({super.key});

  @override
  State<Screen12MyCertificates> createState() => _Screen12MyCertificatesState();
}

class _Screen12MyCertificatesState extends State<Screen12MyCertificates>
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Certificates', style: AppTextStyles.heading2),
        centerTitle: true,
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
              Tab(text: 'Blockchain'),
              Tab(text: 'Traditional'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCertificatesList(),
          _buildCertificatesList(), // Placeholder for Blockchain
          _buildCertificatesList(), // Placeholder for Traditional
        ],
      ),
    );
  }

  Widget _buildCertificatesList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
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
                      hintText: 'Search certificates',
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
          const SizedBox(height: 24),

          // List of Certificates
          _buildCertificateCard(
            'Tech Summit 2024',
            'July 15, 2024',
            'Blockchain',
            const Color(0xFFB2DFDB),
          ),
          _buildCertificateCard(
            'Leadership Workshop',
            'June 20, 2024',
            null,
            const Color(0xFF00796B),
          ),
          _buildCertificateCard(
            'Digital Marketing Conference',
            'May 5, 2024',
            'Blockchain',
            const Color(0xFFD7CCC8),
          ),
          _buildCertificateCard(
            'Project Management Seminar',
            'April 10, 2024',
            null,
            const Color(0xFFCFD8DC),
          ),

          const SizedBox(height: 32),

          // Empty State section (as seen in screenshot bottom)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFFBE9E7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const SizedBox(height: 100), // Placeholder for illustration
                const Text(
                  'No certificates yet',
                  style: AppTextStyles.heading2,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Attend events to earn your first certificate',
                  style: AppTextStyles.bodyText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.analyticsLightGreen,
                    foregroundColor: AppColors.darkText,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Attend Events',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(
    String title,
    String date,
    String? type,
    Color imageColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (type != null)
                  Text(
                    type,
                    style: const TextStyle(
                      color: AppColors.lightText,
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
                  date,
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
