import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Screen21CreateEventStep2 extends StatefulWidget {
  const Screen21CreateEventStep2({super.key});

  @override
  State<Screen21CreateEventStep2> createState() =>
      _Screen21CreateEventStep2State();
}

class _Screen21CreateEventStep2State extends State<Screen21CreateEventStep2> {
  bool allDayEvent = false;

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
        title: const Text('Create Event', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            const Text(
              'Step 2 of 5',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(height: 4, color: AppColors.primaryGreen),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(height: 4, color: AppColors.primaryGreen),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 4,
                    color: AppColors.lightGreyBackground,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 4,
                    color: AppColors.lightGreyBackground,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 4,
                    color: AppColors.lightGreyBackground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Schedule & Timing', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            const Text(
              'Set your event\'s date, time, and timezone',
              style: AppTextStyles.bodyText,
            ),
            const SizedBox(height: 32),

            // Date Selection
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    'Start Date',
                    'Select\ndate',
                    Icons.calendar_today,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    'End Date',
                    'Select\ndate',
                    Icons.calendar_today,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Time Selection
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    'Start Time',
                    'Select\ntime',
                    Icons.access_time,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    'End Time',
                    'Select\ntime',
                    Icons.access_time,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Timezone
            const Text(
              'Timezone',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Select',
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.darkText,
                  ),
                ),
                enabled: false,
              ),
            ),
            const SizedBox(height: 32),

            // All-day Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All-day event',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Switch(
                  value: allDayEvent,
                  onChanged: (v) => setState(() => allDayEvent = v),
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.primaryGreen,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: AppColors.dividerColor,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavActions(),
    );
  }

  Widget _buildInputField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavActions() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(color: AppColors.lightGreyBackground),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.searchBarFillColor,
                  foregroundColor: AppColors.darkText,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () => context.pushNamed('createEventStep3'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // App standard bottom bar icons simulation
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home_outlined, color: AppColors.darkText),
              Icon(
                Icons.calendar_today_outlined,
                color: AppColors.primaryGreen,
              ),
              Icon(Icons.add_box_outlined, color: AppColors.primaryGreen),
              Icon(Icons.inbox_outlined, color: AppColors.primaryGreen),
              Icon(Icons.person_outline, color: AppColors.primaryGreen),
            ],
          ),
        ],
      ),
    );
  }
}
