import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/step_progress_indicator.dart';
import '../widgets/accordion_section.dart';

/// Screen 24: Review Screen (Step 5 of 5)
class Screen24Review extends StatelessWidget {
  const Screen24Review({Key? key}) : super(key: key);

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
        title: const Text('Review', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 5 of 5', style: AppTextStyles.bodyText),
            const SizedBox(height: 8),
            const StepProgressIndicator(
              currentStep: 5,
              totalSteps: 5,
              activeColor: AppColors.oliveGreen,
            ),
            const SizedBox(height: 24),

            // 1. Basic Information (Updated with Type & Format from Schema)
            AccordionSection(
              title: 'Basic Information',
              isExpanded: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _SummaryRow(label: 'Event Name', value: 'Tech Summit 2024'),
                  _SummaryRow(label: 'Type', value: 'Conference'),
                  _SummaryRow(label: 'Format', value: 'Physical (In-person)'),
                  _SummaryRow(label: 'Category', value: 'Technology'),
                  _SummaryRow(label: 'Visibility', value: 'Public'),
                  SizedBox(height: 8),
                  Text('Description:', style: AppTextStyles.label),
                  Text(
                    'A premier tech conference featuring industry leaders, workshops, and networking opportunities.',
                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 2. Schedule
            const AccordionSection(
              title: 'Schedule',
              child: Column(
                children: [
                  _SummaryRow(label: 'Dates', value: 'Aug 20 - Aug 22, 2024'),
                  _SummaryRow(label: 'Time', value: '9:00 AM - 5:00 PM (Daily)'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 3. Location
            const AccordionSection(
              title: 'Location',
              child: Column(
                children: [
                  _SummaryRow(label: 'Venue', value: 'Convention Center, NY'),
                  _SummaryRow(label: 'Address', value: '123 Innovation Way, NY 10001'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 4. Capacity & Pricing (Added from Schema)
            AccordionSection(
              title: 'Capacity & Pricing',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Capacity', style: AppTextStyles.heading3),
                  const _SummaryRow(label: 'Total Seats', value: '150'),
                  const _SummaryRow(label: 'Reserved Seats', value: '20'),
                  const Divider(height: 24),
                  const Text('Pricing Tiers', style: AppTextStyles.heading3),
                  const _SummaryRow(label: 'Early Bird', value: '1500 PKR (Until Mar 15)'),
                  const _SummaryRow(label: 'Regular', value: '2000 PKR'),
                  const Divider(height: 24),
                  const Text('Discounts', style: AppTextStyles.heading3),
                  const _SummaryRow(label: 'Student', value: '20% (Verification Required)'),
                  const _SummaryRow(label: 'Group (5+)', value: '15%'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 5. Registration Form (Added from Schema)
            const AccordionSection(
              title: 'Registration Form',
              child: Column(
                children: [
                  _SummaryRow(label: 'Custom Fields', value: '3 Fields Added'),
                  _SummaryRow(label: 'Fields', value: 'University ID, Job Role, LinkedIn'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 6. Speakers (Added from Schema)
            const AccordionSection(
              title: 'Speakers',
              child: Column(
                children: [
                  _SummaryRow(label: 'Dr. Anya Sharma', value: 'Chief Innovation Officer'),
                  _SummaryRow(label: 'Ethan Carter', value: 'Lead Developer'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 7. Certificates (Added from Schema)
            const AccordionSection(
              title: 'Certificates',
              child: Column(
                children: [
                  _SummaryRow(label: 'Issue Certificates', value: 'Yes'),
                  _SummaryRow(label: 'Type', value: 'Digital + Blockchain'),
                  _SummaryRow(label: 'Requirement', value: '80% Attendance'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Actions
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Save as Draft',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor: AppColors.darkText,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Publish Event',
                    backgroundColor: AppColors.oliveGreen,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavIcon('assets/images/homeicon.svg'),
          _buildNavIcon('assets/images/searchicon.svg'),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.darkText,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              'assets/images/addicon.svg',
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 24,
            ),
          ),
          _buildNavIcon('assets/images/ticketicon.svg'),
          _buildNavIcon('assets/images/profileicon.svg'),
        ],
      ),
    );
  }

  Widget _buildNavIcon(String asset) {
    return SvgPicture.asset(
      asset,
      colorFilter: const ColorFilter.mode(AppColors.lightText, BlendMode.srcIn),
      width: 28,
    );
  }
}

/// Helper widget for clean summary rows
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.label),
          Flexible(
            child: Text(
              value,
              style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}