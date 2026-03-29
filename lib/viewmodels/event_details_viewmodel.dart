// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/event_model.dart';
import '../models/registration_models/pricing_tier_model.dart';

class EventDetailsState {
  final EventModel event;
  final bool isLoading;
  final String errorMessage;
  final int activeTabIndex;
  final List<EventModel> similarEvents;

  const EventDetailsState({
    required this.event,
    this.isLoading = false,
    this.errorMessage = '',
    this.activeTabIndex = 0,
    this.similarEvents = const [],
  });

  EventDetailsState copyWith({
    EventModel? event,
    bool? isLoading,
    String? errorMessage,
    int? activeTabIndex,
    List<EventModel>? similarEvents,
  }) {
    return EventDetailsState(
      event: event ?? this.event,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      similarEvents: similarEvents ?? this.similarEvents,
    );
  }
}

class EventDetailsViewModel extends StateNotifier<EventDetailsState> {
  EventDetailsViewModel()
    : super(EventDetailsState(event: EventModel.empty(), isLoading: true)) {
    loadEventDetails('E001'); // Load dummy initial data
  }

  Future<void> loadEventDetails(String eventId) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final mainEvent = EventModel.empty().copyWith(
        title: 'Tech Summit 2024',
        category: 'Technology',
        description:
            'Join us for Tech Summit 2024, a premier event for tech enthusiasts and professionals. Explore the latest trends, network with industry leaders, and gain insights into the future of technology.',
        organizerName: 'Innovate Events',
        startDate: 'Oct 15, 2024',
        startTime: '9:00 AM',
        endTime: '5:00 PM',
        venueName: 'San Francisco Convention Center',
        isFree: false,
        tiers: [
          PricingTierModel(
            id: 'T1',
            name: 'Standard',
            price: 150,
            availableUntil: '',
            seats: 500,
          ),
        ],
        bannerImage: 'assets/images/s41image1.jpg',
      );

      final similarEvents = [
        EventModel.empty().copyWith(
          title: 'AI in Business',
          startDate: 'Oct 15',
          bannerImage: 'assets/images/s40image6.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Design Thinking Workshop',
          startDate: 'Nov 5',
          bannerImage: 'assets/images/s40image11.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Sustainable Energy Expo',
          startDate: 'Nov 20',
          bannerImage: 'assets/images/s41image3.jpg',
        ),
        EventModel.empty().copyWith(
          title: 'Cybersecurity Summit',
          startDate: 'Dec 12',
          bannerImage: 'assets/images/s41image4.jpg',
        ),
      ];

      state = state.copyWith(
        event: mainEvent,
        similarEvents: similarEvents,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load event details.',
      );
    }
  }

  void setTabIndex(int index) {
    state = state.copyWith(activeTabIndex: index);
  }
}

final eventDetailsProvider =
    StateNotifierProvider<EventDetailsViewModel, EventDetailsState>((ref) {
      return EventDetailsViewModel();
    });
