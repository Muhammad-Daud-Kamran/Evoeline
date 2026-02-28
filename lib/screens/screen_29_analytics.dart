import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/analytics_stat_card.dart';
import '../widgets/horizontal_progress_bar.dart';
import '../widgets/analytics_chart_mockups.dart';

/// Screen 30: Analytics
class Screen29Analytics extends StatelessWidget {
  const Screen29Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Analytics', style: AppTextStyles.heading3),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Event Performance', style: AppTextStyles.heading3),
            const SizedBox(height: 12),

            // Event Header Card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last 7 days',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.successGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('Event Name', style: AppTextStyles.heading3),
                    const SizedBox(height: 4),
                    const Text(
                      '123 Main St, Anytown',
                      style: AppTextStyles.label,
                    ),
                  ],
                ),
                Container(
                  width: 98,
                  height: 65,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE9E7),
                    borderRadius: BorderRadius.circular(8),
                    // TODO: To add image:
                    image: DecorationImage(image: AssetImage('assets/images/screen29image1.jpg'), fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tabs Mockup
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xFFE8F2EB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Overview',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: const Text(
                        'Attendees',
                        style: TextStyle(
                          color: AppColors.lightText,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Date Filters
            Row(
              children: [
                const _FilterChip(label: 'Last 7 days', isActive: true),
                const SizedBox(width: 8),
                const _FilterChip(label: 'Last 30 days'),
                const SizedBox(width: 8),
                const _FilterChip(label: 'Custom'),
              ],
            ),
            const SizedBox(height: 16),

            // Stat Cards Grid
            Row(
              children: const [
                Expanded(
                  child: AnalyticsStatCard(
                    title: 'Registration\nRate',
                    value: '85%',
                    change: '+5%',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: AnalyticsStatCard(
                    title: 'Attendance\nRate',
                    value: '78%',
                    change: '-2%',
                    isPositive: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(
                  child: AnalyticsStatCard(
                    title: 'Satisfaction\nScore',
                    value: '4.5/5',
                    change: '+1%',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: AnalyticsStatCard(
                    title: 'ROI Percentage\n',
                    value: '15%',
                    change: '+3%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Charts Section
            const Text('Charts', style: AppTextStyles.heading3),
            const SizedBox(height: 16),

            // Registration Timeline
            const Text('Registration Timeline', style: AppTextStyles.label),
            const SizedBox(height: 4),
            const Text('1200', style: AppTextStyles.heading1),
            Row(
              children: [
                const Text('Last 7 Days ', style: AppTextStyles.label),
                Text(
                  '+10%',
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.successGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const RegistrationLineChartMockup(),
            const SizedBox(height: 8),
            const _ChartXAxis(),
            const SizedBox(height: 24),

            // Check-in Timeline
            const Text('Check-in Timeline', style: AppTextStyles.label),
            const SizedBox(height: 4),
            const Text('900', style: AppTextStyles.heading1),
            Row(
              children: [
                const Text('Last 7 Days ', style: AppTextStyles.label),
                Text(
                  '-5%',
                  style: AppTextStyles.label.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const CheckInBarChartMockup(),
            const SizedBox(height: 8),
            const _ChartXAxis(),
            const SizedBox(height: 24),

            // Demographics Section
            const Text('Demographics Breakdown', style: AppTextStyles.label),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '40%',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    children: [
                      const Text('Total ', style: AppTextStyles.label),
                      Text(
                        '+2%',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.successGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const HorizontalProgressBar(label: '18-24', progress: 0.15),
            const HorizontalProgressBar(label: '25-34', progress: 0.40),
            const HorizontalProgressBar(label: '35-44', progress: 0.25),
            const HorizontalProgressBar(label: '45+', progress: 0.20),
            const SizedBox(height: 24),

            // Registration Sources Section
            const Text('Registration Sources', style: AppTextStyles.label),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '30%',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    children: [
                      const Text('Total ', style: AppTextStyles.label),
                      Text(
                        '+8%',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.successGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const HorizontalProgressBar(label: 'LinkedIn', progress: 0.30),
            const HorizontalProgressBar(label: 'WhatsApp', progress: 0.60),
            const HorizontalProgressBar(label: 'Direct', progress: 0.45),
            const HorizontalProgressBar(label: 'Other', progress: 0.40),
            const SizedBox(height: 24),

            // Feedback Summary Section
            const Text('Feedback Summary', style: AppTextStyles.heading3),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 125,
                    decoration: BoxDecoration(
                      color: AppColors.analyticsLightGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Overall Ratings', style: AppTextStyles.label),
                        SizedBox(height: 8),
                        Text('4.5/5', style: AppTextStyles.heading2),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.analyticsLightGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Comments\nSentiment', style: AppTextStyles.label),
                        SizedBox(height: 8),
                        Text(
                          'Positive: 70% | Neutral: 20% | Negative: 10%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.analyticsLightGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Key Takeaways', style: AppTextStyles.label),
                  SizedBox(height: 8),
                  Text(
                    'Insight 1: High satisfaction with speakers. Insight 2: Need more networking opportunities.',
                    style: AppTextStyles.heading3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            CustomButton(text: 'Export Analytics Report', onPressed: () {}),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Compare with Similar Events',
              backgroundColor: AppColors.analyticsLightGreen,
              textColor: AppColors.darkText,
              onPressed: () {},
            ),
            const SizedBox(height: 24),
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
              'assets/images/screen29icon1.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/screen29icon2.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),

            SvgPicture.asset(
              'assets/images/screen29icon3.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),

            SvgPicture.asset(
              'assets/images/screen29icon4.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s26settingsicon.svg',
              colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
              width: 44,
              height: 44,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _FilterChip({Key? key, required this.label, this.isActive = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF5ED),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.darkText : AppColors.lightText,
          fontSize: 12,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _ChartXAxis extends StatelessWidget {
  const _ChartXAxis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days
          .map(
            (day) => Text(
              day,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.successGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
          .toList(),
    );
  }
}
