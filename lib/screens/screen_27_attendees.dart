import 'package:go_router/go_router.dart';
// lib/screens/screen_27_attendees.dart

// ─────────────────────────────────────────────────────
// Screen 27 — Attendees List & Management
//
// PROVIDER: attendeesProvider → AttendeesViewModel
//
// FROM MODEL (schema fields):
//   state.totalRegistered  → Total Registered stat card
//                            count of registrations
//   state.checkedInCount   → Checked In stat card
//                            count where checkIn.checkedIn = true
//   state.noShowCount      → No Show stat card
//                            count where status = no_show
//   state.filteredAttendees→ list of AttendeeItemModel
//     attendee.name           → users.profile.fullName
//     attendee.email          → users.email
//     attendee.isCheckedIn    → registrations.checkIn.checkedIn
//     attendee.statusText     → registrations.status
//     attendee.paymentStatus  → registrations.payment.paymentStatus
//     attendee.paymentAmount  → registrations.payment.amountPaid
//   state.activeFilter     → which chip is highlighted
//
// PREVIOUS MODELS USED:
//   EventModel         → context only (eventId)
//   UserModel          → name, email, avatar (new)
//   RegistrationModel  → status, payment, checkIn (new)
//   AttendeeItemModel  → joins both for display (new)
// ─────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../viewmodels/attendees_viewmodel.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/attendee_stat_card.dart';
import '../widgets/attendee_filter_chip.dart';
import '../widgets/attendee_list_item.dart';

class Screen27Attendees extends ConsumerWidget {
  const Screen27Attendees({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ── READ STATE FROM VIEWMODEL ──────────────────────
    // ref.watch → reads state + rebuilds when changed
    final state = ref.watch(attendeesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text('Attendees', style: AppTextStyles.heading2),
        centerTitle: true,
      ),

      // ── LOADING ────────────────────────────────────
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            )
          // ── ERROR ──────────────────────────────────
          : state.errorMessage.isNotEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(state.errorMessage, style: AppTextStyles.bodyText),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(attendeesProvider.notifier).loadAttendees(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          // ── CONTENT ────────────────────────────────
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Stat Cards Row 1 ───────────
                      Row(
                        children: [
                          // Total Registered
                          // state.totalRegistered
                          // = count of all registrations
                          // schema: registrations collection count
                          Expanded(
                            child: AttendeeStatCard(
                              title: 'Total Registered',
                              value: state.totalRegistered
                                  .toString(), // ← from ViewModel
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Checked In
                          // state.checkedInCount
                          // = count where checkIn.checkedIn = true
                          // schema: registrations.checkIn.checkedIn
                          Expanded(
                            child: AttendeeStatCard(
                              title: 'Checked In',
                              value: state.checkedInCount
                                  .toString(), // ← from ViewModel
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // No Show Stat Card
                      // state.noShowCount
                      // = count where status = no_show
                      // schema: registrations.status = no_show
                      SizedBox(
                        width: double.infinity,
                        child: AttendeeStatCard(
                          title: 'No Show',
                          value: state.noShowCount
                              .toString(), // ← from ViewModel
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Filter Chips ───────────────
                      // state.activeFilter from ViewModel
                      // clicking calls filterAttendees() in ViewModel
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // All filter
                            GestureDetector(
                              onTap: () => ref
                                  .read(attendeesProvider.notifier)
                                  .filterAttendees('All'),
                              child: AttendeeFilterChip(
                                label: 'All',
                                icon: Icons.people_outline,
                                // isActive from state.activeFilter
                                isActive: state.activeFilter == 'All',
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Registered filter
                            GestureDetector(
                              onTap: () => ref
                                  .read(attendeesProvider.notifier)
                                  .filterAttendees('Registered'),
                              child: AttendeeFilterChip(
                                label: 'Registered',
                                icon: Icons.person_outline,
                                isActive: state.activeFilter == 'Registered',
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Checked In filter
                            GestureDetector(
                              onTap: () => ref
                                  .read(attendeesProvider.notifier)
                                  .filterAttendees('Checked In'),
                              child: AttendeeFilterChip(
                                label: 'Checked In',
                                icon: Icons.check_circle_outline,
                                isActive: state.activeFilter == 'Checked In',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── Search Box ─────────────────
                      // calls searchAttendees() in ViewModel
                      CustomTextField(
                        hintText: 'Search attendees...',
                        prefixIcon: Icons.search,
                        onChanged: (query) => ref
                            .read(attendeesProvider.notifier)
                            .searchAttendees(query),
                      ),
                      const SizedBox(height: 8),

                      // Export button — action only
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Exporting attendee list...'),
                                ),
                              ),
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

                // ── Attendee List ──────────────────────
                // state.filteredAttendees is List<AttendeeItemModel>
                // loop through and build AttendeeListItem for each

                // Empty state
                if (state.filteredAttendees.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.people_outline,
                            size: 48,
                            color: AppColors.lightText,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.searchQuery.isNotEmpty
                                ? 'No results for "${state.searchQuery}"'
                                : 'No attendees found',
                            style: AppTextStyles.subtitle,
                          ),
                        ],
                      ),
                    ),
                  )
                // Attendees list
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.filteredAttendees.length,
                      itemBuilder: (_, index) {
                        // attendee is AttendeeItemModel
                        // built from UserModel + RegistrationModel
                        final attendee = state.filteredAttendees[index];

                        return AttendeeListItem(
                          // attendee.name → users.profile.fullName
                          name: attendee.name,

                          // attendee.email → users.email
                          subtitle: attendee.email,

                          // attendee.isCheckedIn → registrations.checkIn.checkedIn
                          isCheckedIn: attendee.isCheckedIn,

                          // attendee.avatarImagePath → users.profile.profileImageUrl
                          // empty string → shows initial letter instead
                          avatarImagePath: attendee.avatarImagePath.isEmpty
                              ? null
                              : attendee.avatarImagePath,

                          // attendee.statusText → registrations.status formatted
                          statusText: attendee.statusText,

                          // attendee.paymentStatus → registrations.payment.paymentStatus
                          paymentStatus: attendee.paymentStatus,

                          // attendee.paymentAmount → registrations.payment.amountPaid
                          paymentAmount: attendee.paymentAmount.toString(),
                        );
                      },
                    ),
                  ),
              ],
            ),

      // ── Bottom Action Buttons ──────────────────────
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Send Email',
                  backgroundColor: AppColors.primaryGreen,
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening email composer')),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'Generate Certificates',
                  backgroundColor: AppColors.lightGreyBackground,
                  textColor: AppColors.darkText,
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Generating certificates in background...'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
