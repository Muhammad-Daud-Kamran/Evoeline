import 'package:flutter_riverpod/legacy.dart';

class EventRegistrationState {
  final bool isSubmitting;
  final String? errorMessage;
  final String? successMessage;

  // Professional fields
  final String? industry;
  final String? dietaryPreference;

  // Event-Specific Questions
  final bool previousAttendance;
  final bool session1;
  final bool session2;
  final bool session3;

  // How did you hear
  final String? selectedHearAboutUs;

  // Consents
  final bool agreeTerms;
  final bool agreePrivacy;
  final bool agreeMarketing;

  const EventRegistrationState({
    this.isSubmitting = false,
    this.errorMessage,
    this.successMessage,
    this.industry,
    this.dietaryPreference,
    this.previousAttendance = false,
    this.session1 = false,
    this.session2 = false,
    this.session3 = false,
    this.selectedHearAboutUs,
    this.agreeTerms = false,
    this.agreePrivacy = false,
    this.agreeMarketing = false,
  });

  EventRegistrationState copyWith({
    bool? isSubmitting,
    String? errorMessage,
    String? successMessage,
    String? industry,
    String? dietaryPreference,
    bool? previousAttendance,
    bool? session1,
    bool? session2,
    bool? session3,
    String? selectedHearAboutUs,
    bool? agreeTerms,
    bool? agreePrivacy,
    bool? agreeMarketing,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return EventRegistrationState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccess ? null : successMessage ?? this.successMessage,
      industry: industry ?? this.industry,
      dietaryPreference: dietaryPreference ?? this.dietaryPreference,
      previousAttendance: previousAttendance ?? this.previousAttendance,
      session1: session1 ?? this.session1,
      session2: session2 ?? this.session2,
      session3: session3 ?? this.session3,
      selectedHearAboutUs: selectedHearAboutUs ?? this.selectedHearAboutUs,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      agreePrivacy: agreePrivacy ?? this.agreePrivacy,
      agreeMarketing: agreeMarketing ?? this.agreeMarketing,
    );
  }
}

class EventRegistrationViewModel extends StateNotifier<EventRegistrationState> {
  EventRegistrationViewModel() : super(const EventRegistrationState());

  // Available options for dropdowns
  static const List<String> industryOptions = [
    'Technology',
    'Business',
    'Marketing',
    'Healthcare',
    'Finance',
    'Education',
    'Other',
  ];

  static const List<String> dietaryOptions = [
    'No Preference',
    'Vegetarian',
    'Vegan',
    'Halal',
    'Gluten-Free',
    'Kosher',
  ];

  static const List<String> hearAboutUsOptions = [
    'Social Media',
    'University Club',
    'Email Newsletter',
    'Friend/Colleague',
    'Other',
  ];

  void updateIndustry(String? value) {
    state = state.copyWith(industry: value, clearError: true);
  }

  void updateDietary(String? value) {
    state = state.copyWith(dietaryPreference: value, clearError: true);
  }

  void togglePreviousAttendance(bool value) {
    state = state.copyWith(previousAttendance: value);
  }

  void updateSession(int sessionNum, bool value) {
    switch (sessionNum) {
      case 1:
        state = state.copyWith(session1: value);
        break;
      case 2:
        state = state.copyWith(session2: value);
        break;
      case 3:
        state = state.copyWith(session3: value);
        break;
    }
  }

  void toggleHearAboutUs(String option, bool isSelected) {
    state = state.copyWith(
      selectedHearAboutUs: isSelected ? option : null,
    );
  }

  void toggleConsent({bool? terms, bool? privacy, bool? marketing}) {
    state = state.copyWith(
      agreeTerms: terms ?? state.agreeTerms,
      agreePrivacy: privacy ?? state.agreePrivacy,
      agreeMarketing: marketing ?? state.agreeMarketing,
      clearError: true,
    );
  }

  Future<void> submitRegistration({
    required String fullName,
    required String email,
    required String phone,
    required String companyName,
    required String designation,
    required String expectations,
    required String accessibilityRequirements,
    required String emergencyContactName,
    required String emergencyContactPhone,
  }) async {
    // Validate required consents
    if (!state.agreeTerms || !state.agreePrivacy) {
      state = state.copyWith(
        errorMessage:
            'Please agree to the Terms and Conditions and Privacy Policy to proceed.',
        clearSuccess: true,
      );
      return;
    }

    if (fullName.trim().isEmpty || email.trim().isEmpty) {
      state = state.copyWith(
        errorMessage: 'Full Name and Email are required.',
        clearSuccess: true,
      );
      return;
    }

    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      // Simulate network submission
      await Future.delayed(const Duration(milliseconds: 1200));
      state = state.copyWith(
        isSubmitting: false,
        successMessage:
            'Registration successful! Check your email for confirmation.',
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Registration failed. Please try again.',
        clearSuccess: true,
      );
    }
  }
}

final eventRegistrationProvider =
    StateNotifierProvider.autoDispose<
      EventRegistrationViewModel,
      EventRegistrationState
    >((ref) {
      return EventRegistrationViewModel();
    });
