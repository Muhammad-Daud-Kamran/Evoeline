import 'package:go_router/go_router.dart';
// lib/features/events/screens/screen_25_event_details.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// Screen 25 — Event Details (Organizer View)
//
// MVVM ROLE: This is the VIEW
//   → reads data from EventViewModel using ref.watch()
//   → calls methods on EventViewModel using ref.read()
//   → has ZERO hardcoded data
//   → has ZERO business logic
//
// EVERY value shown comes from EventModel via EventState
// ─────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../models/registration_models/pricing_tier_model.dart';
import '../viewmodels/event_viewmodel.dart';
import '../widgets/info_chip.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/stat_card_with_image.dart';

// ── ConsumerWidget = StatelessWidget that can use Riverpod
class Screen25EventDetails extends ConsumerWidget {
  const Screen25EventDetails({Key? key}) : super(key: key);

  @override
  // WidgetRef ref = your connection to the provider
  Widget build(BuildContext context, WidgetRef ref) {
    // ── READ STATE FROM VIEWMODEL ────────────────────
    // ref.watch() reads state AND rebuilds when it changes
    // state.event gives us the full EventModel
    final state = ref.watch(eventProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text('Event Details', style: AppTextStyles.heading2),
        centerTitle: true,
      ),

      // ── SHOW LOADING ──────────────────────────────
      // state.isLoading comes from EventViewModel
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            )
          // ── SHOW ERROR ────────────────────────────
          // state.errorMessage comes from EventViewModel
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
                    // Retry button calls loadEvent() in ViewModel
                    onPressed: () =>
                        ref.read(eventProvider.notifier).loadEvent(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          // ── SHOW CONTENT ──────────────────────────
          : _buildContent(context, ref, state),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ── Main Content Builder ───────────────────────────
  // Extracted so build() stays clean and readable
  Widget _buildContent(BuildContext context, WidgetRef ref, EventState state) {
    // Shortcut — so we write event.title instead of state.event.title
    final event = state.event;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Banner Image ───────────────────────────
          // event.bannerImage comes from EventModel
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(event.bannerImage), // ← from model
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Event Title ──────────────────────
                // event.title comes from EventModel
                Text(
                  event.title, // ← from model
                  style: AppTextStyles.heading1,
                ),
                const SizedBox(height: 4),

                // ── Category + Venue ─────────────────
                // event.category + event.venueName from EventModel
                Text(
                  '${_capitalize(event.category)} | ${event.venueName}',
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 16),

                // ── Info Chips ───────────────────────
                // All values come from EventModel
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    InfoChip(
                      label: event.startDate, // ← from model
                    ),
                    InfoChip(
                      label:
                          '${event.startTime} - ${event.endTime}', // ← from model
                    ),
                    InfoChip(
                      // Capitalize first letter of status
                      label: _capitalize(event.status), // ← from model
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Tab Bar ──────────────────────────
                // state.activeTabIndex comes from EventState
                // tab switch calls switchTab() in ViewModel
                CustomTabBar(
                  tabs: const ['Overview', 'Attendees', 'Agenda', 'Vendors'],
                  activeIndex: state.activeTabIndex, // ← from state
                  // Note: to make tabs tappable, CustomTabBar needs
                  // an onTap callback — see widget update below
                ),
                const SizedBox(height: 24),

                // ── Gallery Image ────────────────────
                // event.galleryImages[0] from EventModel
                if (event.galleryImages.isNotEmpty)
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyBackground,
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(
                          event.galleryImages[0], // ← from model
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),

                // ── Stat Cards ───────────────────────
                // event.registrations + event.totalSeats + event.availableSeats
                // all come from EventModel
                Row(
                  children: [
                    Expanded(
                      child: StatCardWithImage(
                        title: 'Total Registered',
                        // registrations/totalSeats from model
                        value: '${event.registrations} / ${event.totalSeats}',
                        icon: Icons.bar_chart,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCardWithImage(
                        title: 'Remaining Seats',
                        // availableSeats from model
                        value: '${event.availableSeats} Available',
                        icon: Icons.event_seat_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── About This Event ──────────────────
                // event.description comes from EventModel
                const Text('About this Event', style: AppTextStyles.heading2),
                const SizedBox(height: 8),
                Text(
                  event.description, // ← from model
                  style: AppTextStyles.bodyText,
                ),
                const SizedBox(height: 24),

                // ── Tickets & Pricing ─────────────────
                // Only show when event is paid
                // event.isFree from EventModel
                const Text('Tickets & Pricing', style: AppTextStyles.heading2),
                const SizedBox(height: 12),

                if (event.isFree)
                  // Free event — show free badge
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primaryGreen,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'This is a FREE event',
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  // Paid event — loop through tiers from EventModel
                  // event.tiers is List<PricingTierModel>
                  ...event.tiers.map(
                    (tier) => _buildTicketTier(
                      tier: tier,
                      currency: event.currency, // PKR from model
                    ),
                  ),

                const SizedBox(height: 24),

                // ── Action Buttons ────────────────────
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.people_outline,
                          color: AppColors.darkText,
                        ),
                        label: const Text(
                          'Manage\nAttendees',
                          style: AppTextStyles.bodyText,
                          textAlign: TextAlign.center,
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(color: AppColors.dividerColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.workspace_premium_outlined,
                          color: AppColors.darkText,
                        ),
                        label: const Text(
                          'View\nCertificates',
                          style: AppTextStyles.bodyText,
                          textAlign: TextAlign.center,
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(color: AppColors.dividerColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Ticket Tier Card ──────────────────────────────
  // Receives a PricingTierModel — NO hardcoded values
  Widget _buildTicketTier({
    required PricingTierModel tier,
    required String currency,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightGreyBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // tier.name from PricingTierModel
                Text(tier.name, style: AppTextStyles.heading3),

                // tier.availableUntil from PricingTierModel
                Text(
                  'Until: ${tier.availableUntil}',
                  style: AppTextStyles.label,
                ),

                // tier.seats from PricingTierModel
                Text('${tier.seats} seats', style: AppTextStyles.label),
              ],
            ),

            // currency from EventModel + tier.price from PricingTierModel
            Text(
              '$currency ${tier.price.toInt()}',
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helper: capitalize first letter ──────────────
  // "technology" → "Technology"
  // "published"  → "Published"
  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
