import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';

class Screen16AnalyticsDashboard extends StatelessWidget {
  const Screen16AnalyticsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text('Analytics Dashboard', style: AppTextStyles.heading2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.file_download_outlined,
              color: AppColors.darkText,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading report...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeframe selection
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.lightGreyBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTimeframeTab('Week', isSelected: false),
                  ),
                  Expanded(
                    child: _buildTimeframeTab('Month', isSelected: true),
                  ),
                  Expanded(
                    child: _buildTimeframeTab('Quarter', isSelected: false),
                  ),
                  Expanded(
                    child: _buildTimeframeTab('Year', isSelected: false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stat Grid
            Row(
              children: [
                Expanded(child: _buildStatCard('Total Events', '12')),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Total Attendees', '2,450')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Avg\nSatisfaction\nScore', '4.8'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard('Revenue\nGenerated', 'Rs.\n1,250,000'),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Charts Section Placeholder
            const Text('Event Attendance Trend', style: AppTextStyles.heading3),
            const SizedBox(height: 16),
            _buildChartPlaceholder(120),

            const SizedBox(height: 32),
            const Text(
              'Event Type Distribution',
              style: AppTextStyles.heading3,
            ),
            const SizedBox(height: 16),
            _buildChartPlaceholder(100),

            const SizedBox(height: 32),
            const Text('Registration Sources', style: AppTextStyles.heading3),
            const SizedBox(height: 16),
            _buildChartPlaceholder(100),

            const SizedBox(height: 32),
            const Text('Monthly Comparison', style: AppTextStyles.heading3),
            const SizedBox(height: 16),
            _buildChartPlaceholder(100),

            const SizedBox(height: 32),

            // Top Performing Events
            const Text('Top Performing Events', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            _buildEventItem(
              'Tech Conference 2024',
              '150 attendees, 4.9 rating',
            ),
            _buildEventItem('Marketing Summit', '200 attendees, 4.7 rating'),
            _buildEventItem('Design Workshop', '100 attendees, 4.6 rating'),

            const SizedBox(height: 32),

            // Actions
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Export Report',
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Report exported!')),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.pushNamed('analytics'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.analyticsLightGreen,
                  foregroundColor: AppColors.darkText,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Detailed Analytics',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeframeTab(String label, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.analyticsLightGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder(double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightGreyBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'Chart Component Placeholder',
          style: TextStyle(color: AppColors.lightText),
        ),
      ),
    );
  }

  Widget _buildEventItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.darkText,
              size: 20,
            ),
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
                    fontSize: 14,
                    color: AppColors.darkText,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.lightText,
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
}
