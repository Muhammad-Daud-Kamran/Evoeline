// lib/features/registration/screens/registration_setup_screen.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is Screen 23 — Step 4 of 5
// Organizer sets up registration settings for their event
//
// MVVM ROLE: This is the VIEW
// It ONLY shows UI
// It reads data FROM ViewModel using ref.watch()
// It calls methods ON ViewModel using ref.read()
// It has ZERO logic of its own
// ─────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../models/registration_models/pricing_tier_model.dart';
import '../models/registration_models/discount_model.dart';
import '../models/registration_models/custom_field_model.dart';
import '../../../viewmodels/registration_setup_viewmodel.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/registration_card.dart';
import '../../../widgets/step_progress_indicator.dart';
import '../../../widgets/accordion_section.dart';
import 'screen_24_review.dart'; // Screen 24

// ── ConsumerWidget = StatelessWidget that can use Riverpod ──
class RegistrationSetupScreen extends ConsumerWidget {
  const RegistrationSetupScreen({super.key});

  @override
  // WidgetRef ref = your connection to all providers
  Widget build(BuildContext context, WidgetRef ref) {

    // ── READ STATE FROM VIEWMODEL ──────────────────────
    // ref.watch() → reads the state AND rebuilds when state changes
    // Every time ViewModel calls state = state.copyWith(...)
    // this screen automatically rebuilds
    final state = ref.watch(registrationSetupProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Create Event', style: AppTextStyles.heading2),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Step Indicator ─────────────────────────
            const Text('Step 4 of 5 - Registration',
                style: AppTextStyles.bodyText),
            const SizedBox(height: 8),
            const StepProgressIndicator(currentStep: 4, totalSteps: 5),
            const SizedBox(height: 24),

            // ── Enable Registration Toggle ─────────────
            // state.registrationEnabled → comes from ViewModel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enable Registration',
                    style: AppTextStyles.bodyText),
                Switch(
                  value: state.registrationEnabled, // ← from ViewModel
                  onChanged: (val) {
                    // ref.read() → calls method WITHOUT rebuilding
                    ref.read(registrationSetupProvider.notifier)
                        .toggleRegistration(val);
                  },
                  activeColor: AppColors.primaryGreen,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Registration Schedule Card ─────────────
            const RegistrationCard(
              title:       'Registration Schedule',
              description: 'Set the dates when registration opens and closes.',
              buttonText:  'Set Dates',
              iconData:    Icons.calendar_today_outlined,
              imagePath:   'assets/images/registrationpage_image1.jpg',
            ),
            const SizedBox(height: 24),

            // ── Capacity & Payment Card ────────────────
            const RegistrationCard(
              title:       'Capacity & Payment',
              description: 'Manage event capacity, waitlist, and ticket pricing.',
              buttonText:  'Configure',
              iconData:    Icons.confirmation_num_outlined,
              imagePath:   'assets/images/registrationpage_image2.jpg',
            ),
            const SizedBox(height: 24),

            // ── Pricing & Tiers Accordion ──────────────
            AccordionSection(
              title:      'Pricing & Tiers',
              isExpanded: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Free Event toggle + Currency display
                  Row(
                    children: [
                      const Text('Free Event',
                          style: AppTextStyles.bodyText),
                      Switch(
                        value: state.isFree, // ← from ViewModel
                        onChanged: (val) => ref
                            .read(registrationSetupProvider.notifier)
                            .toggleFreeEvent(val),
                        activeColor: AppColors.primaryGreen,
                      ),
                      const Spacer(),
                      // Only show currency when event is paid
                      if (!state.isFree) ...[
                        const Text('Currency: ',
                            style: AppTextStyles.label),
                        Text(
                          state.currency, // ← from ViewModel
                          style: AppTextStyles.bodyText
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ],
                  ),
                  const Divider(),

                  // Show tiers list only when event is paid
                  if (!state.isFree) ...[

                    // Loop through tiers from ViewModel state
                    // state.tiers is List<PricingTierModel>
                    ...state.tiers.map(
                          (tier) => _TierItem(
                        tier:     tier,
                        currency: state.currency,
                        onDelete: () => ref
                            .read(registrationSetupProvider.notifier)
                            .removeTier(tier.id),
                      ),
                    ),

                    const SizedBox(height: 12),
                    CustomButton(
                      text:            '+ Add Pricing Tier',
                      backgroundColor: AppColors.lightGreyBackground,
                      textColor:       AppColors.darkText,
                      onPressed: () =>
                          _showAddTierDialog(context, ref),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Discounts Accordion ────────────────────
            AccordionSection(
              title: 'Discounts',
              child: Column(
                children: [

                  // Student Discount section
                  // state.studentDiscount is a DiscountModel
                  _DiscountSection(
                    title:     'Student Discount',
                    discount:  state.studentDiscount,
                    showVerification: true,
                    onToggle: (val) => ref
                        .read(registrationSetupProvider.notifier)
                        .toggleStudentDiscount(val),
                    onPercentChanged: (val) => ref
                        .read(registrationSetupProvider.notifier)
                        .setStudentDiscountPercent(val),
                    onVerificationToggle: (val) => ref
                        .read(registrationSetupProvider.notifier)
                        .toggleStudentVerification(val),
                    onMinGroupChanged: null,
                  ),

                  const Divider(height: 32),

                  // Group Discount section
                  _DiscountSection(
                    title:     'Group Discount',
                    discount:  state.groupDiscount,
                    showVerification: false,
                    onToggle: (val) => ref
                        .read(registrationSetupProvider.notifier)
                        .toggleGroupDiscount(val),
                    onPercentChanged: (val) => ref
                        .read(registrationSetupProvider.notifier)
                        .setGroupDiscountPercent(val),
                    onVerificationToggle: null,
                    onMinGroupChanged: (val) => ref
                        .read(registrationSetupProvider.notifier)
                        .setMinGroupSize(val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Custom Registration Fields Accordion ───
            AccordionSection(
              title: 'Custom Registration Fields',
              child: Column(
                children: [

                  // Loop through custom fields from ViewModel state
                  // state.customFields is List<CustomFieldModel>
                  ...state.customFields.map(
                        (field) => _CustomFieldItem(
                      field:    field,
                      onDelete: () => ref
                          .read(registrationSetupProvider.notifier)
                          .removeCustomField(field.fieldId),
                    ),
                  ),

                  const SizedBox(height: 12),
                  CustomButton(
                    text:            '+ Add Custom Field',
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor:       AppColors.darkText,
                    onPressed: () =>
                        _showAddFieldDialog(context, ref),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),

      // ── Bottom Nav Buttons ───────────────────────────
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                text:            'Back',
                backgroundColor: AppColors.lightGreyBackground,
                textColor:       AppColors.darkText,
                width:           100,
                onPressed:       () => Navigator.of(context).pop(),
              ),
              CustomButton(
                text:  'Next',
                width: 100,
                onPressed: () {
                  // Navigate to Screen 24 (Review)
                  // Both screens share the SAME provider
                  // so Screen 24 automatically sees all the data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Screen24Review(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Add Tier Dialog ──────────────────────────────────
  // This dialog collects input then calls ViewModel method
  void _showAddTierDialog(BuildContext context, WidgetRef ref) {

    // Controllers hold what user types
    final nameController  = TextEditingController();
    final priceController = TextEditingController();
    final seatsController = TextEditingController();
    final untilController = TextEditingController(text: '2024-12-31');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Pricing Tier',
            style: AppTextStyles.heading3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: 'Tier Name (e.g. Regular)'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration:
              const InputDecoration(labelText: 'Price (PKR)'),
            ),
            TextField(
              controller: seatsController,
              keyboardType: TextInputType.number,
              decoration:
              const InputDecoration(labelText: 'Seats Limit'),
            ),
            TextField(
              controller: untilController,
              decoration: const InputDecoration(
                  labelText: 'Available Until (YYYY-MM-DD)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Validate inputs are not empty before adding
              if (nameController.text.isNotEmpty &&
                  priceController.text.isNotEmpty) {

                // Call ViewModel method with dialog inputs
                ref
                    .read(registrationSetupProvider.notifier)
                    .addTier(
                  name:           nameController.text,
                  price:          double.tryParse(priceController.text) ?? 0,
                  seats:          int.tryParse(seatsController.text) ?? 0,
                  availableUntil: untilController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // ── Add Custom Field Dialog ──────────────────────────
  void _showAddFieldDialog(BuildContext context, WidgetRef ref) {

    final labelController = TextEditingController();
    String selectedType   = 'Text';
    bool   isRequired     = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        // StatefulBuilder allows local state inside dialog
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Custom Field',
              style: AppTextStyles.heading3),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelController,
                decoration:
                const InputDecoration(labelText: 'Field Label'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: ['Text', 'Dropdown', 'Checkbox']
                    .map((v) => DropdownMenuItem(
                  value: v,
                  child: Text(v),
                ))
                    .toList(),
                onChanged: (val) =>
                    setDialogState(() => selectedType = val!),
                decoration:
                const InputDecoration(labelText: 'Field Type'),
              ),
              Row(
                children: [
                  Checkbox(
                    value:      isRequired,
                    onChanged:  (v) =>
                        setDialogState(() => isRequired = v!),
                    activeColor: AppColors.primaryGreen,
                  ),
                  const Text('Mark as Required',
                      style: AppTextStyles.label),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (labelController.text.isNotEmpty) {
                  // Call ViewModel method
                  ref
                      .read(registrationSetupProvider.notifier)
                      .addCustomField(
                    label:      labelController.text,
                    type:       selectedType,
                    isRequired: isRequired,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════
// PRIVATE HELPER WIDGETS
// These are small widgets used only inside this screen
// Keeping them here avoids creating separate files
// for things that are not reused anywhere else
// ═════════════════════════════════════════════════════

// ── Tier Item Widget ─────────────────────────────────
// Shows ONE pricing tier row with delete button
class _TierItem extends StatelessWidget {
  final PricingTierModel tier;
  final String           currency;
  final VoidCallback     onDelete;

  const _TierItem({
    required this.tier,
    required this.currency,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // tier.name comes from PricingTierModel
              Text(tier.name, style: AppTextStyles.heading3),
              Text(
                'Seats: ${tier.seats} | Until: ${tier.availableUntil}',
                style: AppTextStyles.label,
              ),
            ],
          ),
          Row(
            children: [
              // tier.price comes from PricingTierModel
              Text(
                '$currency ${tier.price.toInt()}',
                style: AppTextStyles.heading3
                    .copyWith(color: AppColors.primaryGreen),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onDelete, // calls removeTier in ViewModel
                child: const Icon(Icons.delete_outline,
                    size: 20, color: AppColors.lightText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Discount Section Widget ──────────────────────────
// Shows ONE discount section (student OR group)
class _DiscountSection extends StatelessWidget {
  final String        title;
  final DiscountModel discount;     // the data from ViewModel
  final bool          showVerification;
  final Function(bool)    onToggle;
  final Function(String)  onPercentChanged;
  final Function(bool)?   onVerificationToggle;
  final Function(String)? onMinGroupChanged;

  const _DiscountSection({
    required this.title,
    required this.discount,
    required this.showVerification,
    required this.onToggle,
    required this.onPercentChanged,
    this.onVerificationToggle,
    this.onMinGroupChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.bodyText),
            Switch(
              value:       discount.isEnabled, // ← from DiscountModel
              onChanged:   onToggle,
              activeColor: AppColors.primaryGreen,
            ),
          ],
        ),

        // Show fields only when discount is enabled
        if (discount.isEnabled) ...[

          // Percentage field
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged:    onPercentChanged,
              decoration: InputDecoration(
                labelText: 'Percentage (%)',
                // Show current value as hint
                hintText: discount.percentage.toString(),
                labelStyle: AppTextStyles.label,
                border: const UnderlineInputBorder(),
              ),
            ),
          ),

          // Requires Verification checkbox (student discount only)
          if (showVerification && onVerificationToggle != null)
            Row(
              children: [
                Checkbox(
                  value:      discount.requiresVerification,
                  onChanged:  (v) => onVerificationToggle!(v!),
                  activeColor: AppColors.primaryGreen,
                ),
                const Text('Requires Verification',
                    style: AppTextStyles.label),
              ],
            ),

          // Min Group Size (group discount only)
          if (!showVerification && onMinGroupChanged != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged:    onMinGroupChanged,
                decoration: InputDecoration(
                  labelText: 'Min Group Size',
                  hintText:  discount.minGroupSize.toString(),
                  labelStyle: AppTextStyles.label,
                  border: const UnderlineInputBorder(),
                ),
              ),
            ),
        ],
      ],
    );
  }
}

// ── Custom Field Item Widget ─────────────────────────
// Shows ONE custom field row with delete button
class _CustomFieldItem extends StatelessWidget {
  final CustomFieldModel field;
  final VoidCallback     onDelete;

  const _CustomFieldItem({
    required this.field,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      // field.label comes from CustomFieldModel
      title: Text(field.label, style: AppTextStyles.bodyText),
      subtitle: Text(
        // field.type and field.isRequired from CustomFieldModel
        'Type: ${field.type} | ${field.isRequired ? 'Required' : 'Optional'}',
        style: AppTextStyles.label,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, size: 20),
        onPressed: onDelete, // calls removeCustomField in ViewModel
      ),
    );
  }
}