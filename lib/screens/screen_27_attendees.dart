import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/attendee_stat_card.dart';
import '../widgets/attendee_filter_chip.dart';
import '../widgets/attendee_list_item.dart';

/// Screen 27: Attendees List & Management
class Screen27Attendees extends StatelessWidget {
  const Screen27Attendees({Key? key}) : super(key: key);

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
        title: const Text('Attendees', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Stat Cards
                Row(
                  children: const [
                    Expanded(
                      child: AttendeeStatCard(
                        title: 'Total Registered',
                        value: '250',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: AttendeeStatCard(
                        title: 'Checked In',
                        value: '180',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const SizedBox(
                  width: double.infinity,
                  child: AttendeeStatCard(title: 'No Show', value: '20'),
                ),
                const SizedBox(height: 24),

                // Filters Scrollable Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      AttendeeFilterChip(
                        label: 'All',
                        icon: Icons.people_outline,
                        isActive: true,
                      ),
                      SizedBox(width: 8),
                      AttendeeFilterChip(
                        label: 'Registered',
                        icon: Icons.person_outline,
                      ),
                      SizedBox(width: 8),
                      AttendeeFilterChip(
                        label: 'Checked In',
                        icon: Icons.check_circle_outline,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Search Box
                const CustomTextField(
                  hintText: 'Search attendees...',
                  prefixIcon: Icons.search,
                ),
                const SizedBox(height: 8),

                // Export Button Overlay Alternative
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Export Attendee List',
                      style: TextStyle(
                        color: AppColors.darkText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Attendee List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                // TODO: Replace names and emails with real variables.
                // To display an avatar, pass `avatarImagePath` like below:
                // AttendeeListItem(name: 'Olivia Smith', email: 'olivia.smith@email.com', isCheckedIn: true, avatarImagePath: 'assets/images/user_olivia.png'),
                AttendeeListItem(
                  name: 'Olivia Smith',
                  subtitle: 'olivia.smith@email.com',
                  isCheckedIn: true,
                ),
                AttendeeListItem(
                  name: 'Liam Johnson',
                  subtitle: 'liam.johnson@email.com',
                  isCheckedIn: true,
                ),
                AttendeeListItem(
                  name: 'Emma Brown',
                  subtitle: 'emma.brown@email.com',
                  isCheckedIn: true,
                ),
                AttendeeListItem(
                  name: 'Noah Davis',
                  subtitle: 'noah.davis@email.com',
                  isCheckedIn: true,
                ),
                AttendeeListItem(
                  name: 'Isabella Wilson',
                  subtitle: 'isabella.wilson@email.com',
                  isCheckedIn: true,
                ),
                AttendeeListItem(
                  name: 'James Garcia',
                  subtitle: 'james.garcia@email.com',
                  isCheckedIn: true,
                ),
                AttendeeListItem(
                  name: 'Sophia Rodriguez',
                  subtitle: 'sophia.rodriguez@email.com',
                  isCheckedIn: true,
                ),
                AttendeeListItem(
                  name: 'Benjamin Lee',
                  subtitle: 'benjamin.lee@email.com',
                  isCheckedIn: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Send Email',
                  backgroundColor: AppColors.primaryGreen,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'Generate Certificates',
                  backgroundColor: AppColors.lightGreyBackground,
                  textColor: AppColors.darkText,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
