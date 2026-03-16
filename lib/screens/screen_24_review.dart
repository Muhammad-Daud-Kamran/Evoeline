// lib/features/registration/screens/review_screen.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is Screen 24 — Step 5 of 5 — The Review Screen
//
// IMPORTANT: This screen uses the SAME provider as Screen 23
// So it automatically sees ALL the data the organizer set up
// No need to pass data between screens manually
//
// MVVM ROLE: This is the VIEW
// It READS data from the ViewModel (same one as Screen 23)
// It calls publishEvent() and saveAsDraft() on the ViewModel
// ─────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../viewmodels/registration_setup_viewmodel.dart';
import '../../../viewmodels/event_viewmodel.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/step_progress_indicator.dart';
import '../../../widgets/accordion_section.dart';

class Screen24Review extends ConsumerWidget {
  const Screen24Review({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // ── READ SAME STATE AS SCREEN 23 ──────────────────
    // Same provider → same data → automatic sync
    // Whatever organizer set in Screen 23 shows here
    final state = ref.watch(registrationSetupProvider);
    final eventState = ref.watch(eventProvider);
    final event      = eventState.event;// shortcut so we write event.startDate not state.event.startDate



    // Navigate away when event is published successfully
    if (state.isPublished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // TODO: Navigate to dashboard or success screen
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }

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

            // Step Indicator
            const Text('Step 5 of 5', style: AppTextStyles.bodyText),
            const SizedBox(height: 8),
            const StepProgressIndicator(
              currentStep:  5,
              totalSteps:   5,
              activeColor:  AppColors.oliveGreen,
            ),
            const SizedBox(height: 24),

            // ── 1. Basic Information ───────────────────
            // Static data for now — will come from EventViewModel later
            AccordionSection(
              title:      'Basic Information',
              isExpanded: true,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SummaryRow(label: 'Event Name', value: 'Tech Summit 2024'),
                  _SummaryRow(label: 'Type',       value: 'Conference'),
                  _SummaryRow(label: 'Format',     value: 'Physical (In-person)'),
                  _SummaryRow(label: 'Category',   value: 'Technology'),
                  _SummaryRow(label: 'Visibility', value: 'Public'),
                  SizedBox(height: 8),
                  Text('Description:', style: AppTextStyles.label),
                  Text(
                    'A premier tech conference featuring industry leaders.',
                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── 2. Schedule ────────────────────────────
            AccordionSection(
              title: 'Schedule',
              child: Column(
                children: [
                  _SummaryRow(label: 'Dates', value: '${event.startDate} - ${event.endDate}',),
                  _SummaryRow(label: 'Time',  value: '${event.startTime} - ${event.endTime}'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── 3. Location ────────────────────────────
            const AccordionSection(
              title: 'Location',
              child: Column(
                children: [
                  _SummaryRow(label: 'Venue',   value: 'Convention Center, NY'),
                  _SummaryRow(label: 'Address', value: '123 Innovation Way, NY'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── 4. Capacity & Pricing ──────────────────
            // THIS SECTION SHOWS LIVE DATA FROM VIEWMODEL
            AccordionSection(
              title: 'Capacity & Pricing',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Show free or paid status from ViewModel
                  _SummaryRow(
                    label: 'Pricing',
                    value: state.isFree  // ← LIVE from ViewModel
                        ? 'Free Event'
                        : 'Paid Event (${state.currency})',
                  ),

                  // Only show tiers if paid event
                  if (!state.isFree) ...[
                    const SizedBox(height: 8),
                    const Text('Pricing Tiers',
                        style: AppTextStyles.heading3),

                    // Loop through tiers from ViewModel
                    // These are the EXACT tiers organizer added in Screen 23
                    ...state.tiers.map(
                          (tier) => _SummaryRow(
                        label: tier.name, // ← from PricingTierModel
                        value: '${state.currency} ${tier.price.toInt()} '
                            '(${tier.seats} seats)',
                      ),
                    ),
                  ],

                  const Divider(height: 24),
                  const Text('Discounts', style: AppTextStyles.heading3),

                  // Student discount summary from ViewModel
                  _SummaryRow(
                    label: 'Student Discount',
                    // Shows enabled status and percentage from DiscountModel
                    value: state.studentDiscount.isEnabled
                        ? '${state.studentDiscount.percentage}% '
                        '(${state.studentDiscount.requiresVerification ? 'Verification Required' : 'No Verification'})'
                        : 'Disabled',
                  ),

                  // Group discount summary from ViewModel
                  _SummaryRow(
                    label: 'Group Discount',
                    value: state.groupDiscount.isEnabled
                        ? '${state.groupDiscount.percentage}% '
                        '(Min ${state.groupDiscount.minGroupSize} people)'
                        : 'Disabled',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── 5. Registration Form ───────────────────
            // THIS SECTION SHOWS LIVE DATA FROM VIEWMODEL
            AccordionSection(
              title: 'Registration Form',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SummaryRow(
                    label: 'Custom Fields',
                    // state.customFields.length → count from ViewModel
                    value: '${state.customFields.length} Fields Added',
                  ),
                  const SizedBox(height: 8),

                  // Loop through custom fields from ViewModel
                  // These are the EXACT fields organizer added in Screen 23
                  ...state.customFields.map(
                        (field) => _SummaryRow(
                      label: field.label, // ← from CustomFieldModel
                      value: '${field.type} | '
                          '${field.isRequired ? 'Required' : 'Optional'}',
                    ),
                  ),

                  // Show message if no fields added yet
                  if (state.customFields.isEmpty)
                    const Text('No custom fields added',
                        style: AppTextStyles.label),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── 6. Speakers ────────────────────────────
            const AccordionSection(
              title: 'Speakers',
              child: Column(
                children: [
                  _SummaryRow(
                      label: 'Dr. Anya Sharma',
                      value: 'Chief Innovation Officer'),
                  _SummaryRow(
                      label: 'Ethan Carter',
                      value: 'Lead Developer'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── 7. Certificates ────────────────────────
            const AccordionSection(
              title: 'Certificates',
              child: Column(
                children: [
                  _SummaryRow(label: 'Issue Certificates', value: 'Yes'),
                  _SummaryRow(label: 'Type',               value: 'Digital + Blockchain'),
                  _SummaryRow(label: 'Requirement',        value: '80% Attendance'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Error Message ──────────────────────────
            // Only shows when state.errorMessage is not empty
            if (state.errorMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color:        Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border:       Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage, // ← from ViewModel
                        style: const TextStyle(
                            color: Colors.red, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

            // ── Action Buttons ─────────────────────────
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text:            state.isLoading
                        ? 'Saving...'
                        : 'Save as Draft',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor:       AppColors.darkText,
                    onPressed: state.isLoading
                        ? () {}
                        : () => ref
                        .read(registrationSetupProvider.notifier)
                        .saveAsDraft(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text:            state.isLoading
                        ? 'Publishing...'
                        : 'Publish Event',
                    backgroundColor: AppColors.oliveGreen,
                    onPressed: state.isLoading
                        ? () {}
                        : () => ref
                        .read(registrationSetupProvider.notifier)
                        .publishEvent(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),

      // ── Bottom Nav Bar ─────────────────────────────
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color:  AppColors.background,
        border: Border(
            top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset('assets/images/homeicon.svg',
              colorFilter: const ColorFilter.mode(
                  AppColors.lightText, BlendMode.srcIn),
              width: 28),
          SvgPicture.asset('assets/images/searchicon.svg',
              colorFilter: const ColorFilter.mode(
                  AppColors.lightText, BlendMode.srcIn),
              width: 28),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:        AppColors.darkText,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset('assets/images/addicon.svg',
                colorFilter: const ColorFilter.mode(
                    Colors.white, BlendMode.srcIn),
                width: 24),
          ),
          SvgPicture.asset('assets/images/ticketicon.svg',
              colorFilter: const ColorFilter.mode(
                  AppColors.lightText, BlendMode.srcIn),
              width: 28),
          SvgPicture.asset('assets/images/profileicon.svg',
              colorFilter: const ColorFilter.mode(
                  AppColors.lightText, BlendMode.srcIn),
              width: 28),
        ],
      ),
    );
  }
}

// ── Summary Row Widget ───────────────────────────────
// Reusable row that shows label on left, value on right
// Used throughout Screen 24
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({
    required this.label,
    required this.value,
  });

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
              style: AppTextStyles.bodyText
                  .copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}