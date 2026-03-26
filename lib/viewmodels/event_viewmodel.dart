// lib/viewmodels/event_viewmodel.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/event_model.dart';
import '../models/registration_models/pricing_tier_model.dart';
import '../models/registration_models/discount_model.dart';
import '../models/registration_models/custom_field_model.dart';

class EventState {
  final EventModel event;
  final bool isLoading;
  final String errorMessage;
  final int activeTabIndex;

  const EventState({
    required this.event,
    this.isLoading = false,
    this.errorMessage = '',
    this.activeTabIndex = 0,
  });

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

class EventViewModel extends StateNotifier<EventState> {
  EventViewModel()
      : super(EventState(
          event: EventModel.empty(),
          isLoading: true,
        )) {
    loadEvent();
  }

  Future<void> loadEvent() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final event = _getDummyEvent();
      state = state.copyWith(
        event: event,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load event. Please try again.',
      );
    }
  }

  void switchTab(int index) {
    state = state.copyWith(activeTabIndex: index);
  }

  double get budgetProgress {
    if (state.event.budgetTotal == 0) return 0.0;
    final progress = state.event.budgetSpent / state.event.budgetTotal;
    return progress.clamp(0.0, 1.0);
  }

  String get budgetStatusLabel {
    final spent = state.event.budgetSpent.toInt();
    final total = state.event.budgetTotal.toInt();
    return '\$$spent / \$$total';
  }

  String get budgetPercentageLabel {
    return '+${(budgetProgress * 100).toInt()}%';
  }

  String get coOrganizersText {
    if (state.event.coOrganizers.isEmpty) return 'None';
    return state.event.coOrganizers.join(', ');
  }

  String get sponsorsText {
    if (state.event.sponsors.isEmpty) return 'None';
    return state.event.sponsors.join(', ');
  }

  String get partnersText {
    if (state.event.partners.isEmpty) return 'None';
    return state.event.partners.join(', ');
  }

  EventModel _getDummyEvent() {
    return const EventModel(
      eventId: 'EVT001',
      organizerId: 'U002',
      title: 'Tech Summit 2024',
      description: 'A premier tech conference featuring industry leaders, workshops, and networking opportunities. Join us to explore the future of AI, Cloud Computing, and Blockchain technology.',
      shortDescription: 'Innovate, Connect, Transform', // Fixed to match Screen 31
      category: 'technology',
      eventType: 'conference',
      format: 'physical',
      status: 'published',
      visibility: 'public',
      bannerImage: 'assets/images/screen31image1.jpg', // Fixed to match Screen 31 image
      galleryImages: ['assets/images/banner2screen25.jpg'],
      startDate: 'Oct 20, 2024', // Fixed to match Screen 31
      endDate: 'Oct 22, 2024',
      startTime: '9:00 AM',
      endTime: '5:00 PM',
      timezone: 'PKT',
      venueName: 'FAST University, Lahore', // Fixed to match Screen 31
      address: 'Main Hall, FAST University, Lahore',
      city: 'Lahore',
      country: 'Pakistan',
      latitude: 31.4815,
      longitude: 74.3030,
      totalSeats: 150,
      reservedSeats: 20,
      availableSeats: 30,
      registrationOpenDate: '2024-07-01',
      registrationCloseDate: '2024-08-19',
      requiresApproval: false,
      customFields: [
        CustomFieldModel(
          fieldId: 'F001',
          label: 'University ID',
          type: 'Text',
          isRequired: true,
        ),
      ],
      isFree: false,
      currency: 'PKR',
      tiers: [
        PricingTierModel(
          id: 'T001',
          name: 'Early Bird',
          price: 1500,
          availableUntil: 'Mar 15',
          seats: 30,
        ),
      ],
      organizerName: 'Tech Innovators Inc.',
      coOrganizers: ['Sarah Chen', 'David Lee'],
      sponsors: ['Innovate Solutions', 'FutureTech', 'Global Partners'],
      partners: ['Global Partners Network'],
      budgetSpent: 15000,
      budgetTotal: 20000,
      issueCertificates: true,
      certificateType: 'both',
      minAttendance: 80,
      mustCompleteSurvey: true,
      views: 1245,
      registrations: 120,
      checkIns: 85,
      completionRate: 95.5,
      revenue: 178000,
      createdAt: '2024-01-15',
      updatedAt: '2024-03-01',
      publishedAt: '2024-03-01',
    );
  }
}

final eventProvider = StateNotifierProvider<EventViewModel, EventState>((ref) {
  return EventViewModel();
});
