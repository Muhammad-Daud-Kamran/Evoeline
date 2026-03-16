// lib/viewmodels/event_viewmodel.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// ViewModel for Screen 25 — Event Details
//
// CONTAINS:
//   EventState       → snapshot of everything Screen 25 needs
//   EventViewModel   → loads data + holds methods
//   eventProvider    → connects both to the UI
//
// DATABASE: not connected yet — using dummy data
// When Firebase is ready just replace _loadDummyEvent()
// with a Firestore call inside loadEvent()
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../models/registration_models/pricing_tier_model.dart';
import '../models/registration_models/discount_model.dart';
import '../models/registration_models/custom_field_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// Holds everything Screen 25 needs to display
// ═════════════════════════════════════════════════════

class EventState {
  // The main event object
  // This is the EventModel that Screen 25 reads from
  final EventModel event;

  // Loading state — shows spinner while data loads
  final bool isLoading;

  // Error state — shows error message if load fails
  final String errorMessage;

  // Active tab index — Overview=0, Attendees=1, Agenda=2, Vendors=3
  // Kept in state because tab switching is UI behaviour
  final int activeTabIndex;

  const EventState({
    required this.event,
    this.isLoading = false,
    this.errorMessage = '',
    this.activeTabIndex = 0,
  });

  // copyWith — create new state with only changed fields
  EventState copyWith({
    EventModel? event,
    bool? isLoading,
    String? errorMessage,
    int? activeTabIndex,
  }) {
    return EventState(
      event: event ?? this.event,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// All logic lives here — NO widgets, NO UI code
// ═════════════════════════════════════════════════════

class EventViewModel extends Notifier<EventState> {
  @override
  EventState build() {
    Future.microtask(loadEvent);
    return EventState(event: EventModel.empty(), isLoading: true);
  }

  // ── Load Event ─────────────────────────────────────
  // Called automatically when screen opens
  // Replace Future.delayed with Firestore call later
  Future<void> loadEvent() async {
    // Show loading spinner
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // Simulate network delay
      // REPLACE THIS with Firestore:
      // final doc = await FirebaseFirestore.instance
      //     .collection('events')
      //     .doc('EVT001')
      //     .get();
      // final event = EventModel.fromMap(doc.data()!);
      await Future.delayed(const Duration(milliseconds: 800));

      // Load dummy event data matching the schema exactly
      final event = _getDummyEvent();

      // Update state → Screen 25 rebuilds automatically
      state = state.copyWith(event: event, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load event. Please try again.',
      );
    }
  }

  // ── Switch Tab ─────────────────────────────────────
  // Called when user taps Overview/Attendees/Agenda/Vendors
  void switchTab(int index) {
    state = state.copyWith(activeTabIndex: index);
  }

  // ── Dummy Event Data ───────────────────────────────
  // All field values match the schema exactly
  // Remove this method when Firebase is connected
  EventModel _getDummyEvent() {
    return EventModel(
      // Core Identity
      eventId: 'EVT001',
      organizerId: 'U002',
      title: 'Tech Summit 2024',
      description:
          'A premier tech conference featuring industry leaders, '
          'workshops, and networking opportunities. Join us to '
          'explore the future of AI, Cloud Computing, and '
          'Blockchain technology.',
      shortDescription: '2-day intensive tech conference',
      category: 'technology',
      eventType: 'conference',
      format: 'physical',
      status: 'published', // shows Published chip
      visibility: 'public',

      // Media
      bannerImage: 'assets/images/banner1screen25.jpg',
      galleryImages: ['assets/images/banner2screen25.jpg'],

      // Schedule — matches schema: schedule.*
      startDate: 'Aug 20, 2024',
      endDate: 'Aug 22, 2024',
      startTime: '9:00 AM',
      endTime: '5:00 PM',
      timezone: 'PKT',

      // Location — matches schema: location.*
      venueName: 'Convention Center, NY',
      address: '123 Innovation Way, NY 10001',
      city: 'New York',
      country: 'USA',
      latitude: 40.7128,
      longitude: -74.0060,

      // Capacity — matches schema: capacity.*
      totalSeats: 150,
      reservedSeats: 20,
      availableSeats: 30,

      // Registration — matches schema: registration.*
      registrationOpenDate: '2024-07-01',
      registrationCloseDate: '2024-08-19',
      requiresApproval: false,

      // Custom Fields — matches schema: registration.customForm[]
      customFields: const [
        CustomFieldModel(
          fieldId: 'F001',
          label: 'University ID',
          type: 'Text',
          isRequired: true,
        ),
        CustomFieldModel(
          fieldId: 'F002',
          label: 'Job Role',
          type: 'Dropdown',
          isRequired: false,
          options: ['Student', 'Developer', 'Manager'],
        ),
      ],

      // Pricing — matches schema: pricing.*
      isFree: false,
      currency: 'PKR',

      // Tiers — matches schema: pricing.tiers[]
      tiers: const [
        PricingTierModel(
          id: 'T001',
          name: 'Early Bird',
          price: 1500,
          availableUntil: 'Mar 15',
          seats: 30,
        ),
        PricingTierModel(
          id: 'T002',
          name: 'Regular',
          price: 2000,
          availableUntil: 'Apr 14',
          seats: 60,
        ),
      ],

      // Student Discount — matches schema: pricing.studentDiscount
      studentDiscount: const DiscountModel(
        isEnabled: true,
        percentage: 20,
        requiresVerification: true,
      ),

      // Group Discount — matches schema: pricing.groupDiscount
      groupDiscount: const DiscountModel(
        isEnabled: true,
        percentage: 15,
        minGroupSize: 5,
      ),

      // Certificate Config — matches schema: certificateConfig.*
      issueCertificates: true,
      certificateType: 'both',
      minAttendance: 80,
      mustCompleteSurvey: true,

      // Analytics — matches schema: analytics.*
      views: 1245,
      registrations: 120, // used in stat card "120 / 150"
      checkIns: 85,
      completionRate: 95.5,
      revenue: 178000,

      // Timestamps
      createdAt: '2024-01-15',
      updatedAt: '2024-03-01',
      publishedAt: '2024-03-01',
    );
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// The connector between ViewModel and Screen 25
// Import this provider in Screen 25 to use it
// ═════════════════════════════════════════════════════

final eventProvider = NotifierProvider<EventViewModel, EventState>(
  EventViewModel.new,
);
