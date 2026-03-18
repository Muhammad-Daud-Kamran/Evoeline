import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../models/registration_models/pricing_tier_model.dart';

// ─────────────────────────────────────────────────────
// PART A — STATE CLASS
// ─────────────────────────────────────────────────────
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

// ─────────────────────────────────────────────────────
// PART B — VIEWMODEL CLASS
// ─────────────────────────────────────────────────────
class EventViewModel extends Notifier<EventState> {
  @override
  EventState build() {
    // Return empty state initially
    return EventState(event: EventModel.empty());
  }

  // Load event data (Mock for now)
  Future<void> loadEvent() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock Data reflecting the screenshots/requirements
      final mockEvent = EventModel(
        eventId: 'EVT001',
        organizerId: 'ORG001',
        title: 'Tech Summit 2024',
        description:
            'A premier tech conference featuring industry leaders, hands-on workshops, and networking opportunities. Join us for two days of innovation and inspiration.',
        shortDescription: 'The biggest tech event of the year.',
        category: 'Technology',
        eventType: 'Conference',
        format: 'Physical',
        status: 'Published',
        bannerImage: 'assets/images/event_banner.jpg',
        galleryImages: ['assets/images/gallery1.jpg'],
        startDate: '15 Apr 2024',
        endDate: '16 Apr 2024',
        startTime: '10:00 AM',
        endTime: '05:00 PM',
        venueName: 'Convention Center, NY',
        address: '123 Innovation Way, NY',
        totalSeats: 500,
        availableSeats: 42,
        registrations: 458,
        isFree: false,
        currency: 'PKR',
        tiers: [
          const PricingTierModel(
            id: 'T1',
            name: 'Early Bird',
            price: 1500,
            availableUntil: '2024-03-15',
            seats: 100,
          ),
          const PricingTierModel(
            id: 'T2',
            name: 'Regular',
            price: 2500,
            availableUntil: '2024-04-10',
            seats: 400,
          ),
        ],
      );

      state = state.copyWith(isLoading: false, event: mockEvent);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load event details.',
      );
    }
  }

  void switchTab(int index) {
    state = state.copyWith(activeTabIndex: index);
  }
}

// ─────────────────────────────────────────────────────
// PART C — PROVIDER
// ─────────────────────────────────────────────────────
final eventProvider = NotifierProvider<EventViewModel, EventState>(() {
  return EventViewModel();
});
