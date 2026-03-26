import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';

class MyEventsState {
  final List<EventModel> attendingEvents;
  final List<EventModel> organizingEvents;
  final bool isLoading;
  final String errorMessage;

  const MyEventsState({
    this.attendingEvents = const [],
    this.organizingEvents = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  MyEventsState copyWith({
    List<EventModel>? attendingEvents,
    List<EventModel>? organizingEvents,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MyEventsState(
      attendingEvents: attendingEvents ?? this.attendingEvents,
      organizingEvents: organizingEvents ?? this.organizingEvents,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class MyEventsViewModel extends Notifier<MyEventsState> {
  @override
  MyEventsState build() {
    Future.microtask(loadMyEvents);
    return const MyEventsState();
  }

  Future<void> loadMyEvents() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(milliseconds: 900));

      final attendingObj = EventModel.empty().copyWith(
        eventId: 'att_1',
        title: 'Design Thinking Workshop',
        bannerImage: 'assets/images/design_workshop.jpg',
      );
      final organizingObj = EventModel.empty().copyWith(
        eventId: 'org_1',
        title: 'My Tech Meetup',
        bannerImage: 'assets/images/my_meetup.jpg',
      );

      state = state.copyWith(
        attendingEvents: [attendingObj],
        organizingEvents: [organizingObj],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Could not load your events',
      );
    }
  }
}

final myEventsProvider = NotifierProvider<MyEventsViewModel, MyEventsState>(
  MyEventsViewModel.new,
);
