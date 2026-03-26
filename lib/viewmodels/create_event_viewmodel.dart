import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';

class CreateEventState {
  final EventModel draftEvent;
  final bool isSubmitting;
  final String errorMessage;

  const CreateEventState({
    required this.draftEvent,
    this.isSubmitting = false,
    this.errorMessage = '',
  });

  CreateEventState copyWith({
    EventModel? draftEvent,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return CreateEventState(
      draftEvent: draftEvent ?? this.draftEvent,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class CreateEventViewModel extends Notifier<CreateEventState> {
  @override
  CreateEventState build() {
    return CreateEventState(draftEvent: EventModel.empty());
  }

  void updateBasicInfo({
    String? title,
    String? category,
    String? startDate,
    String? startTime,
    String? location,
  }) {
    final updatedEvent = state.draftEvent.copyWith(
      title: title,
      category: category,
      startDate: startDate,
      startTime: startTime,
      address: location,
    );
    state = state.copyWith(draftEvent: updatedEvent);
  }

  void updateMediaAndDetails({String? description, String? bannerImage}) {
    final updatedEvent = state.draftEvent.copyWith(
      description: description,
      bannerImage: bannerImage,
    );
    state = state.copyWith(draftEvent: updatedEvent);
  }

  Future<bool> publishEvent() async {
    state = state.copyWith(isSubmitting: true, errorMessage: '');
    try {
      // Simulate network request to save event to database
      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(
        isSubmitting: false,
        // Reset the draft event after publishing
        draftEvent: EventModel.empty(),
      );
      return true; // Success
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to publish event. Try again.',
      );
      return false; // Failure
    }
  }
}

final createEventProvider =
    NotifierProvider<CreateEventViewModel, CreateEventState>(
      CreateEventViewModel.new,
    );
