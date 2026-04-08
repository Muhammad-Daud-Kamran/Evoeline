import 'package:go_router/go_router.dart';
// lib/screens/screen_26_event_overview.dart

// ─────────────────────────────────────────────────────
// Screen 26 — Event Overview (Organizer View)
//
// TWO PROVIDERS:
//   eventProvider     → EventViewModel (event_viewmodel.dart)
//   analyticsProvider → AnalyticsViewModel (analytics_viewmodel.dart)
//
// FROM eventProvider + EventViewModel GETTERS:
//   event.title                → header title
//   event.bannerImage          → header image
//   event.checkIns             → Checked In stat card
//   vm.budgetStatusLabel       → Budget stat card value
//   vm.budgetPercentageLabel   → Budget stat card percentage
//   vm.budgetProgress          → progress bar value
//   event.organizerName        → Key Information
//   vm.coOrganizersText        → Key Information
//   vm.sponsorsText            → Key Information
//   vm.partnersText            → Key Information
//   event.registrationOpenDate → Important Dates
//   event.startDate/endDate    → Important Dates
//
// FROM analyticsProvider:
//   analytics.totalRegistrations  → Total Registered stat card
//   analytics.certificatesIssued  → Certificates Issued stat card
// ─────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../viewmodels/event_viewmodel.dart';     // 👈 your existing VM
import '../viewmodels/event_overview_viewmodel.dart'; // 👈 analytics VM
import '../widgets/custom_button.dart';
import '../widgets/overview_stat_card.dart';
import '../widgets/info_list_tile.dart';

class Screen26EventOverview extends ConsumerWidget {
  const Screen26EventOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // ── PROVIDER 1 — Event Data ──────────────────────
    // ref.watch → reads state AND rebuilds when changed
    final eventState = ref.watch(eventProvider);
    final event      = eventState.event;

    // ── ACCESS VIEWMODEL GETTERS ─────────────────────
    // ref.read → access computed getters from EventViewModel
    // we use read here because getters don't need to rebuild
    // they compute from state which watch already handles
    final eventVM = ref.read(eventProvider.notifier);

    // ── PROVIDER 2 — Analytics Data ──────────────────
    final analyticsState = ref.watch(analyticsProvider);
    final analytics      = analyticsState.analytics;

    // ── COMBINED LOADING ──────────────────────────────
    // show spinner if either provider is still loading
    final isLoading = eventState.isLoading || analyticsState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text('Event Overview', style: AppTextStyles.heading2),
        centerTitle: true,
      ),

      // ── LOADING STATE ──────────────────────────────
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryGreen,
        ),
      )

      // ── ERROR STATE ────────────────────────────
          : eventState.errorMessage.isNotEmpty ||
          analyticsState.errorMessage.isNotEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline,
                color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              eventState.errorMessage.isNotEmpty
                  ? eventState.errorMessage
                  : analyticsState.errorMessage,
              style: AppTextStyles.bodyText,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // retry both providers
                ref.read(eventProvider.notifier).loadEvent();
                ref.read(analyticsProvider.notifier).loadAnalytics();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      )

      // ── CONTENT STATE ──────────────────────────
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Header Banner ──────────────────
            // event.bannerImage → schema: events.bannerImage
            // event.title       → schema: events.title
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.iconColor,
              child: Stack(
                children: [

                  // Banner from EventModel
                  Image.asset(
                    event.bannerImage, // ← eventProvider
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  // Title from EventModel
                  Positioned(
                    bottom: 26,
                    left: 16,
                    child: Text(
                      event.title, // ← eventProvider
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Row 1: Stat Cards ──────────
                  Row(
                    children: [

                      // Total Registered
                      // analytics.totalRegistrations
                      // schema: analytics.registrations.total
                      Expanded(
                        child: OverviewStatCard(
                          title: 'Total Registered',
                          value: analytics.totalRegistrations
                              .toString(), // ← analyticsProvider
                          percentage: '+10%',
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Checked In
                      // event.checkIns
                      // schema: events.analytics.checkIns
                      Expanded(
                        child: OverviewStatCard(
                          title: 'Checked In',
                          value: event.checkIns
                              .toString(), // ← eventProvider
                          percentage: '+5%',
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [

                      // Certificates Issued
                      // analytics.certificatesIssued
                      // schema: analytics.certificates.issued
                      Expanded(
                        child: OverviewStatCard(
                          title: 'Certificates Issued',
                          value: analytics.certificatesIssued
                              .toString(), // ← analyticsProvider
                          percentage: '+8%',
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Budget Status
                      // eventVM.budgetStatusLabel
                      // computed getter in EventViewModel
                      // formats budgetSpent/budgetTotal as string
                      Expanded(
                        child: OverviewStatCard(
                          title: 'Budget Status',
                          value: eventVM.budgetStatusLabel,      // ← EventViewModel getter
                          percentage: eventVM.budgetPercentageLabel, // ← EventViewModel getter
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 24),

                  // ── Budget Progress Bar ────────
                  // eventVM.budgetProgress
                  // computed getter in EventViewModel
                  // = budgetSpent / budgetTotal = 0.75
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: eventVM.budgetProgress, // ← EventViewModel getter
                      backgroundColor: AppColors.dividerColor,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.darkText,
                      ),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Key Information ────────────
                  const Text('Key Information',
                      style: AppTextStyles.heading2),
                  const SizedBox(height: 12),

                  // Organizer
                  // event.organizerName from EventModel
                  InfoListTile(
                    icon:     Icons.person_outline,
                    title:    'Organizer',
                    subtitle: event.organizerName, // ← eventProvider
                  ),

                  // Co-Organizers
                  // eventVM.coOrganizersText
                  // computed getter joins coOrganizers list → string
                  // 'Sarah Chen, David Lee'
                  InfoListTile(
                    icon:     Icons.group_outlined,
                    title:    'Co-Organizers',
                    subtitle: eventVM.coOrganizersText, // ← EventViewModel getter
                  ),

                  // Sponsors
                  // eventVM.sponsorsText
                  // computed getter joins sponsors list → string
                  InfoListTile(
                    icon:     Icons.campaign_outlined,
                    title:    'Sponsors',
                    subtitle: eventVM.sponsorsText, // ← EventViewModel getter
                  ),

                  // Partners
                  // eventVM.partnersText
                  // computed getter joins partners list → string
                  InfoListTile(
                    icon:     Icons.handshake_outlined,
                    title:    'Partners',
                    subtitle: eventVM.partnersText, // ← EventViewModel getter
                  ),
                  const SizedBox(height: 24),

                  // ── Important Dates ────────────
                  const Text('Important Dates',
                      style: AppTextStyles.heading2),
                  const SizedBox(height: 12),

                  // Registration Opens
                  // event.registrationOpenDate
                  // schema: registration.registrationOpenDate
                  InfoListTile(
                    icon:     Icons.calendar_month_outlined,
                    title:    'Registration Opens',
                    subtitle: event.registrationOpenDate, // ← eventProvider
                  ),

                  // Event Dates
                  // event.startDate + event.endDate
                  // schema: schedule.startDate + schedule.endDate
                  InfoListTile(
                    icon:     Icons.event_outlined,
                    title:    'Event Dates',
                    subtitle: '${event.startDate} - ${event.endDate}', // ← eventProvider
                  ),
                  const SizedBox(height: 32),

                  // ── Action Buttons ─────────────
                  // navigation only — no ViewModel method needed
                  CustomButton(
                    text:            'View Public Page',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor:       AppColors.darkText,
                    onPressed:       () => context.pushNamed('eventDetails'),
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text:            'Share Event',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor:       AppColors.darkText,
                    onPressed:       () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Event link copied to clipboard!')),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text:            'Edit Details',
                    backgroundColor: AppColors.primaryGreen,
                    onPressed:       () => context.pushNamed('createEventStep1'),
                  ),
                  const SizedBox(height: 16),

                ],
              ),
            ),
          ],
        ),
      ),

      // ── Bottom Navigation Bar ──────────────────────
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color:  AppColors.background,
          border: Border(
            top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {}, // Already on Overview
              child: SvgPicture.asset(
                'assets/images/screen26overviewicon.svg',
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryGreen, BlendMode.srcIn), // Highlight active tab
                width: 44, height: 44,
              ),
            ),
            InkWell(
              onTap: () => context.pushNamed('attendees'),
              child: SvgPicture.asset(
                'assets/images/s26 attendeeicon.svg',
                colorFilter: const ColorFilter.mode(
                    AppColors.lightText, BlendMode.srcIn),
                width: 44, height: 44,
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Schedule management module coming soon!')),
                );
              },
              child: SvgPicture.asset(
                'assets/images/s26scheduleicon.svg',
                colorFilter: const ColorFilter.mode(
                    AppColors.lightText, BlendMode.srcIn),
                width: 44, height: 44,
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Promotional tools module coming soon!')),
                );
              },
              child: SvgPicture.asset(
                'assets/images/s26promoteicon.svg',
                colorFilter: const ColorFilter.mode(
                    AppColors.lightText, BlendMode.srcIn),
                width: 44, height: 44,
              ),
            ),
            InkWell(
              onTap: () => context.pushNamed('settings'),
              child: SvgPicture.asset(
                'assets/images/s26settingsicon.svg',
                colorFilter: const ColorFilter.mode(
                    AppColors.lightText, BlendMode.srcIn),
                width: 44, height: 44,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
