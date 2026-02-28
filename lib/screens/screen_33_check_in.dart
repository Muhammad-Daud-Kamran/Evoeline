import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/solid_stat_card.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/attendee_list_item.dart';

/// Screen 29: Check-in
class Screen33CheckIn extends StatelessWidget {
  const Screen33CheckIn({Key? key}) : super(key: key);
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
        title: const Text('Check-in', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Stat Cards Row
            Row(
              children: const [
                Expanded(
                  child: SolidStatCard(title: 'Total Expected', value: '250'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SolidStatCard(title: 'Checked In', value: '185'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(
              width: double.infinity,
              child: SolidStatCard(title: 'Pending', value: '65'),
            ),
            const SizedBox(height: 24),

            // Search Box
            const CustomTextField(hintText: 'Search', prefixIcon: Icons.search),
            const SizedBox(height: 16),

            // Attendee List
            Expanded(
              child: ListView(
                children: const [
                  // TODO: To use image assets for avatars, pass avatarImagePath argument
                  // e.g. avatarImagePath: 'assets/images/user_ayesha.png',
                  AttendeeListItem(
                    name: 'Ayesha Khan',
                    subtitle: 'Ticket ID: 12345',
                    isCheckedIn: true,
                    subtitleColor: AppColors.lightText,
                  ),
                  AttendeeListItem(
                    name: 'Ethan Carter',
                    subtitle: 'Ticket ID: 67890',
                    isCheckedIn: true,
                    subtitleColor: AppColors.lightText,
                  ),
                  AttendeeListItem(
                    name: 'Olivia Bennett',
                    subtitle: 'Ticket ID: 11223',
                    isCheckedIn: true,
                    subtitleColor: AppColors.lightText,
                  ),
                  AttendeeListItem(
                    name: 'Noah Thompson',
                    subtitle: 'Ticket ID: 33445',
                    isCheckedIn: true,
                    subtitleColor: AppColors.lightText,
                  ),
                  AttendeeListItem(
                    name: 'Sophia Ramirez',
                    subtitle: 'Ticket ID: 55667',
                    isCheckedIn: true,
                    subtitleColor: AppColors.lightText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color:
            AppColors.checkInBottomBarGrey, // Grey bottom bar matching design
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.darkGreenButton, // Darker green for matching design
              foregroundColor: AppColors.darkText, // Dark text on the button
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                'assets/images/s33icon1download.svg',
                colorFilter: const ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
                width: 32,
                height: 30,
              ),
            ),
            label: Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: const Text(
                'Export Check-in Report',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
