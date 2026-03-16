// lib/viewmodels/registration_setup_viewmodel.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is the VIEWMODEL + STATE for Screen 23 and Screen 24
//
// It holds ALL the data that both screens need
// It has ALL the methods that change that data
// Screen 23 WRITES data (organizer sets it up)
// Screen 24 READS data (shows summary before publishing)
//
// RIVERPOD PATTERN:
//   RegistrationSetupState  → holds all the data (snapshot)
//   RegistrationSetupVM     → holds all the methods (logic)
//   registrationSetupProvider → connects both to the UI
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/registration_models/pricing_tier_model.dart';
import '../models/registration_models/discount_model.dart';
import '../models/registration_models/custom_field_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// Think of this as a PHOTOGRAPH of the screen right now
// Every time something changes → a NEW photograph is taken
// ═════════════════════════════════════════════════════

class RegistrationSetupState {

  // ── Section 1: Registration Toggle ──────────────────
  // matches schema: registration.requiresApproval (opposite)
  final bool registrationEnabled;

  // ── Section 2: Pricing ──────────────────────────────
  // matches schema: pricing.isFree
  final bool isFree;

  // matches schema: pricing.currency
  final String currency;

  // matches schema: pricing.tiers[]
  final List<PricingTierModel> tiers;

  // ── Section 3: Discounts ────────────────────────────
  // matches schema: pricing.studentDiscount
  final DiscountModel studentDiscount;

  // matches schema: pricing.groupDiscount
  final DiscountModel groupDiscount;

  // ── Section 4: Custom Fields ────────────────────────
  // matches schema: registration.customForm[]
  final List<CustomFieldModel> customFields;

  // ── Section 5: Screen Status ────────────────────────
  // shows loading spinner when saving
  final bool isLoading;

  // shows error message if something goes wrong
  final String errorMessage;

  // true when organizer clicks Publish
  final bool isPublished;

  // "draft" | "published" — matches schema: events.status
  final String eventStatus;

  // Constructor — all fields have default values
  // so we don't need to pass everything every time
  const RegistrationSetupState({
    this.registrationEnabled = true,
    this.isFree              = false,
    this.currency            = 'PKR',
    this.tiers               = const [],
    this.studentDiscount     = const DiscountModel(
      isEnabled:            true,
      percentage:           20,
      requiresVerification: true,
    ),
    this.groupDiscount = const DiscountModel(
      isEnabled:    true,
      percentage:   15,
      minGroupSize: 5,
    ),
    this.customFields  = const [],
    this.isLoading     = false,
    this.errorMessage  = '',
    this.isPublished   = false,
    this.eventStatus   = 'draft',
  });

  // ── copyWith() ──────────────────────────────────────
  // VERY IMPORTANT FOR RIVERPOD
  // Riverpod needs a NEW object every time state changes
  // copyWith creates a new object with only changed fields
  //
  // Example:
  //   state = state.copyWith(isFree: true)
  //   → creates new state with isFree=true, everything else same
  RegistrationSetupState copyWith({
    bool?                   registrationEnabled,
    bool?                   isFree,
    String?                 currency,
    List<PricingTierModel>?  tiers,
    DiscountModel?          studentDiscount,
    DiscountModel?          groupDiscount,
    List<CustomFieldModel>?  customFields,
    bool?                   isLoading,
    String?                 errorMessage,
    bool?                   isPublished,
    String?                 eventStatus,
  }) {
    return RegistrationSetupState(
      registrationEnabled: registrationEnabled ?? this.registrationEnabled,
      isFree:              isFree              ?? this.isFree,
      currency:            currency            ?? this.currency,
      tiers:               tiers               ?? this.tiers,
      studentDiscount:     studentDiscount     ?? this.studentDiscount,
      groupDiscount:       groupDiscount       ?? this.groupDiscount,
      customFields:        customFields        ?? this.customFields,
      isLoading:           isLoading           ?? this.isLoading,
      errorMessage:        errorMessage        ?? this.errorMessage,
      isPublished:         isPublished         ?? this.isPublished,
      eventStatus:         eventStatus         ?? this.eventStatus,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL CLASS
// This is the BRAIN
// All logic lives here — NO widgets, NO UI code allowed
// ═════════════════════════════════════════════════════

class RegistrationSetupVM extends Notifier<RegistrationSetupState> {

  @override
  RegistrationSetupState build() {
    return const RegistrationSetupState(
      // Pre-filled tiers matching schema dummy data
      tiers: [
        PricingTierModel(
          id:             'T001',
          name:           'Early Bird',
          price:          1500,
          availableUntil: '2024-03-15',
          seats:          30,
        ),
      ],
      // Pre-filled custom fields matching schema
      customFields: [
        CustomFieldModel(
          fieldId:    'F001',
          label:      'University ID',
          type:       'Text',
          isRequired: true,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════
  // SECTION 1 METHODS — Registration Toggle
  // Used by: Screen 23 Enable Registration switch
  // ══════════════════════════════════════════════════

  // Called when organizer flips the Enable Registration switch
  void toggleRegistration(bool value) {
    // state = tells Riverpod "something changed, rebuild the UI"
    state = state.copyWith(registrationEnabled: value);
  }

  // ══════════════════════════════════════════════════
  // SECTION 2 METHODS — Pricing
  // Used by: Screen 23 Pricing & Tiers accordion
  // ══════════════════════════════════════════════════

  // Called when organizer flips Free Event switch
  void toggleFreeEvent(bool value) {
    state = state.copyWith(isFree: value);
  }

  // Called when organizer adds a new pricing tier
  // Parameters come from the Add Tier dialog inputs
  void addTier({
    required String name,
    required double price,
    required int    seats,
    required String availableUntil,
  }) {
    // Create a new PricingTierModel from dialog inputs
    final newTier = PricingTierModel(
      // Use timestamp as unique ID — simple and works without database
      id:             'T${DateTime.now().millisecondsSinceEpoch}',
      name:           name,
      price:          price,
      availableUntil: availableUntil,
      seats:          seats,
    );

    // [...state.tiers, newTier] = create NEW list with old tiers + new tier
    // We create a NEW list because Riverpod needs new objects to detect change
    state = state.copyWith(
      tiers: [...state.tiers, newTier],
    );
  }

  // Called when organizer taps delete on a tier
  void removeTier(String tierId) {
    state = state.copyWith(
      // Filter out the tier with matching ID
      tiers: state.tiers.where((t) => t.id != tierId).toList(),
    );
  }

  // ══════════════════════════════════════════════════
  // SECTION 3 METHODS — Student Discount
  // Used by: Screen 23 Discounts accordion
  // ══════════════════════════════════════════════════

  // Called when organizer flips Student Discount switch
  void toggleStudentDiscount(bool value) {
    // We update the studentDiscount object using its own copyWith
    state = state.copyWith(
      studentDiscount: state.studentDiscount.copyWith(isEnabled: value),
    );
  }

  // Called when organizer changes the percentage field
  void setStudentDiscountPercent(String value) {
    // tryParse handles empty string or invalid number safely
    final percent = int.tryParse(value) ?? 0;
    state = state.copyWith(
      studentDiscount: state.studentDiscount.copyWith(percentage: percent),
    );
  }

  // Called when organizer checks/unchecks "Requires Verification"
  void toggleStudentVerification(bool value) {
    state = state.copyWith(
      studentDiscount: state.studentDiscount.copyWith(
        requiresVerification: value,
      ),
    );
  }

  // ══════════════════════════════════════════════════
  // SECTION 4 METHODS — Group Discount
  // Used by: Screen 23 Discounts accordion
  // ══════════════════════════════════════════════════

  void toggleGroupDiscount(bool value) {
    state = state.copyWith(
      groupDiscount: state.groupDiscount.copyWith(isEnabled: value),
    );
  }

  void setGroupDiscountPercent(String value) {
    final percent = int.tryParse(value) ?? 0;
    state = state.copyWith(
      groupDiscount: state.groupDiscount.copyWith(percentage: percent),
    );
  }

  void setMinGroupSize(String value) {
    final size = int.tryParse(value) ?? 2;
    state = state.copyWith(
      groupDiscount: state.groupDiscount.copyWith(minGroupSize: size),
    );
  }

  // ══════════════════════════════════════════════════
  // SECTION 5 METHODS — Custom Fields
  // Used by: Screen 23 Custom Registration Fields accordion
  // ══════════════════════════════════════════════════

  // Called when organizer fills the Add Custom Field dialog and taps Add
  void addCustomField({
    required String label,
    required String type,
    required bool   isRequired,
  }) {
    final newField = CustomFieldModel(
      fieldId:    'F${DateTime.now().millisecondsSinceEpoch}',
      label:      label,
      type:       type,
      isRequired: isRequired,
    );

    state = state.copyWith(
      customFields: [...state.customFields, newField],
    );
  }

  // Called when organizer taps delete on a custom field
  void removeCustomField(String fieldId) {
    state = state.copyWith(
      customFields: state.customFields
          .where((f) => f.fieldId != fieldId)
          .toList(),
    );
  }

  // ══════════════════════════════════════════════════
  // SECTION 6 METHODS — Actions (Screen 24 buttons)
  // Used by: Screen 24 Save as Draft and Publish buttons
  // ══════════════════════════════════════════════════

  // Called when organizer taps "Save as Draft"
  Future<void> saveAsDraft() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    // Simulate saving — replace with Firestore later
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(
      isLoading:   false,
      eventStatus: 'draft',
      // isPublished stays false
    );
  }

  // Called when organizer taps "Publish Event"
  Future<void> publishEvent() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // Simulate API call — replace with Firestore later
      await Future.delayed(const Duration(seconds: 2));

      // Update status to published — matches schema: events.status
      state = state.copyWith(
        isLoading:   false,
        eventStatus: 'published',
        isPublished: true,  // triggers navigation in Screen 24
      );

    } catch (e) {
      state = state.copyWith(
        isLoading:    false,
        errorMessage: 'Failed to publish. Please try again.',
      );
    }
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// This is the CONNECTOR between ViewModel and all screens
// Think of it as the plug socket
// Both Screen 23 AND Screen 24 use this SAME provider
// so they share the same data automatically
// ═════════════════════════════════════════════════════

final registrationSetupProvider = NotifierProvider<
    RegistrationSetupVM,
    RegistrationSetupState>(
  () => RegistrationSetupVM(),
);