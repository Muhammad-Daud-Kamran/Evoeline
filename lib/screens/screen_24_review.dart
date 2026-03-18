// lib/features/registration/screens/review_screen.dart

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

    // ✅ Correct provider usage
    final state = ref.watch(registrationSetupProvider);
    final eventState = ref.watch(eventProvider);
    final event = eventState.event;

    // Navigate after publish
    if (state.isPublished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
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

            const Text('Step 5 of 5', style: AppTextStyles.bodyText),
            const SizedBox(height: 8),
            const StepProgressIndicator(
              currentStep: 5,
              totalSteps: 5,
              activeColor: AppColors.oliveGreen,
            ),
            const SizedBox(height: 24),

            // BASIC INFO
            const AccordionSection(
              title: 'Basic Information',
              isExpanded: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SummaryRow(label: 'Event Name', value: 'Tech Summit 2024'),
                  _SummaryRow(label: 'Type', value: 'Conference'),
                  _SummaryRow(label: 'Format', value: 'Physical (In-person)'),
                  _SummaryRow(label: 'Category', value: 'Technology'),
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

            // SCHEDULE
            AccordionSection(
              title: 'Schedule',
              child: Column(
                children: [
                  _SummaryRow(
                    label: 'Dates',
                    value: '${event.startDate} - ${event.endDate}',
                  ),
                  _SummaryRow(
                    label: 'Time',
                    value: '${event.startTime} - ${event.endTime}',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // LOCATION
            const AccordionSection(
              title: 'Location',
              child: Column(
                children: [
                  _SummaryRow(label: 'Venue', value: 'Convention Center, NY'),
                  _SummaryRow(label: 'Address', value: '123 Innovation Way, NY'),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // CAPACITY & PRICING
            AccordionSection(
              title: 'Capacity & Pricing',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  _SummaryRow(
                    label: 'Pricing',
                    value: state.isFree
                        ? 'Free Event'
                        : 'Paid Event (${state.currency})',
                  ),

                  if (!state.isFree) ...[
                    const SizedBox(height: 8),
                    const Text('Pricing Tiers',
                        style: AppTextStyles.heading3),

                    ...state.tiers.map(
                          (tier) => _SummaryRow(
                        label: tier.name,
                        value:
                        '${state.currency} ${tier.price.toInt()} (${tier.seats} seats)',
                      ),
                    ),
                  ],

                  const Divider(height: 24),
                  const Text('Discounts', style: AppTextStyles.heading3),

                  _SummaryRow(
                    label: 'Student Discount',
                    value: state.studentDiscount.isEnabled
                        ? '${state.studentDiscount.percentage}% '
                        '(${state.studentDiscount.requiresVerification ? 'Verification Required' : 'No Verification'})'
                        : 'Disabled',
                  ),

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

            // REGISTRATION FORM
            AccordionSection(
              title: 'Registration Form',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SummaryRow(
                    label: 'Custom Fields',
                    value: '${state.customFields.length} Fields Added',
                  ),
                  const SizedBox(height: 8),

                  ...state.customFields.map(
                        (field) => _SummaryRow(
                      label: field.label,
                      value:
                      '${field.type} | ${field.isRequired ? 'Required' : 'Optional'}',
                    ),
                  ),

                  if (state.customFields.isEmpty)
                    const Text('No custom fields added',
                        style: AppTextStyles.label),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ERROR
            if (state.errorMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(
                            color: Colors.red, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

            // BUTTONS
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: state.isLoading ? 'Saving...' : 'Save as Draft',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor: AppColors.darkText,
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
                    text: state.isLoading
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

      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
            top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset('assets/images/homeicon.svg', width: 28),
          SvgPicture.asset('assets/images/searchicon.svg', width: 28),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.darkText,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset('assets/images/addicon.svg',
                width: 24),
          ),
          SvgPicture.asset('assets/images/ticketicon.svg', width: 28),
          SvgPicture.asset('assets/images/profileicon.svg', width: 28),
        ],
      ),
    );
  }
}

// SUMMARY ROW
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