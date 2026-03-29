import 'package:flutter_riverpod/legacy.dart';
import '../models/event_model.dart';
import '../models/registration_models/registration_model.dart';

class RegistrationSuccessState {
  final bool isLoading;
  final String errorMessage;
  final EventModel event;
  final RegistrationModel registration;

  const RegistrationSuccessState({
    this.isLoading = false,
    this.errorMessage = '',
    required this.event,
    required this.registration,
  });

  RegistrationSuccessState copyWith({
    bool? isLoading,
    String? errorMessage,
    EventModel? event,
    RegistrationModel? registration,
  }) {
    return RegistrationSuccessState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      event: event ?? this.event,
      registration: registration ?? this.registration,
    );
  }
}

class RegistrationSuccessViewModel extends StateNotifier<RegistrationSuccessState> {
  RegistrationSuccessViewModel()
      : super(RegistrationSuccessState(
          isLoading: true,
          event: EventModel.empty(),
          registration: const RegistrationModel(
            registrationId: '',
            eventId: '',
            userId: '',
            organizerId: '',
            status: 'confirmed',
          ),
        )) {
    loadSuccessData();
  }

  Future<void> loadSuccessData() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final event = EventModel.empty().copyWith(
        title: 'Tech Summit 2024',
        format: 'physical',
        startDate: 'Sat, Dec 20',
        startTime: '10:00 AM',
        endTime: '4:00 PM',
        bannerImage: 'assets/images/s44image1.jpg',
      );

      const registration = RegistrationModel(
        registrationId: 'EV12345',
        eventId: 'EVT001',
        userId: 'U001',
        organizerId: 'U002',
        status: 'confirmed',
        qrCodeImageUrl: 'assets/images/s44image2.jpg',
        paymentStatus: 'completed',
        amountPaid: 50.0,
        currency: 'USD',
      );

      state = state.copyWith(
        isLoading: false,
        event: event,
        registration: registration,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load registration details.',
      );
    }
  }
}

final registrationSuccessProvider =
    StateNotifierProvider.autoDispose<RegistrationSuccessViewModel, RegistrationSuccessState>((ref) {
  return RegistrationSuccessViewModel();
});
