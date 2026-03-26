import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';

class EventDiscoveryState {
  final List<EventModel> popularEvents;
  final List<EventModel> upcomingEvents;
  final bool isLoading;
  final String errorMessage;

  const EventDiscoveryState({
    this.popularEvents = const [],
    this.upcomingEvents = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  EventDiscoveryState copyWith({
    List<EventModel>? popularEvents,
    List<EventModel>? upcomingEvents,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EventDiscoveryState(
      popularEvents: popularEvents ?? this.popularEvents,
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class EventDiscoveryViewModel extends Notifier<EventDiscoveryState> {
  @override
  EventDiscoveryState build() {
    Future.microtask(loadDiscoverEvents);
    return const EventDiscoveryState();
  }

  Future<void> loadDiscoverEvents() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(seconds: 1));

      final dummyEvent1 = EventModel.empty().copyWith(
        eventId: 'evt_101',
        title: 'Flutter Global Summit',
        status: 'published',
        bannerImage: 'assets/images/banner1.jpg',
      );
      final dummyEvent2 = EventModel.empty().copyWith(
        eventId: 'evt_102',
        title: 'StartUp Pitch 2024',
        status: 'published',
        bannerImage: 'assets/images/banner2.jpg',
      );

      state = state.copyWith(
        popularEvents: [dummyEvent1, dummyEvent2],
        upcomingEvents: [dummyEvent2, dummyEvent1],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch events',
      );
    }
  }
}

final eventDiscoveryProvider =
    NotifierProvider<EventDiscoveryViewModel, EventDiscoveryState>(
      EventDiscoveryViewModel.new,
    );
