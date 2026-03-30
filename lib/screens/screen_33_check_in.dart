import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/solid_stat_card.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/attendee_list_item.dart';
import '../viewmodels/attendees_viewmodel.dart';


class Screen33CheckIn extends ConsumerWidget {
  const Screen33CheckIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendeesProvider);
    final viewModel = ref.read(attendeesProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
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
              children: [
                Expanded(
                  child: SolidStatCard(title: 'Total Expected', value: '${state.totalRegistered}'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SolidStatCard(title: 'Checked In', value: '${state.checkedInCount}'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: SolidStatCard(
                  title: 'Pending',
                  value: '${state.totalRegistered - state.checkedInCount}'),
            ),
            const SizedBox(height: 24),

            // Search Box
            CustomTextField(
                hintText: 'Search',
                prefixIcon: Icons.search,
                onChanged: (val) => viewModel.searchAttendees(val),
            ),
            const SizedBox(height: 16),

            // Attendee List
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: state.filteredAttendees.length,
                      itemBuilder: (context, index) {
                        final attendee = state.filteredAttendees[index];
                        return AttendeeListItem(
                          name: attendee.name,
                          subtitle: attendee.email,
                          isCheckedIn: attendee.isCheckedIn,
                          statusText: attendee.statusText,
                          paymentStatus: attendee.paymentStatus,
                          paymentAmount: attendee.paymentAmount,
                          subtitleColor: AppColors.lightText,
                          // Optional avatar handling from attendee.avatarImagePath if valid
                        );
                      },
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
                colorFilter: const ColorFilter.mode(
                  AppColors.darkText,
                  BlendMode.srcIn,
                ),
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
