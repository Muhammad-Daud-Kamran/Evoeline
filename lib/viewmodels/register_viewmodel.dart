// lib/viewmodels/register_viewmodel.dart

// ─────────────────────────────────────────────────────
// ViewModel for Screen 32 — Register
//
// Simulates user registration.
// Form updates state dynamically and onSubmit creates UserModel+RegistrationModel.
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/legacy.dart';
import '../models/user_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════

class RegisterState {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String city;
  final String country;
  final String dietaryPreferences;
  final String accessibilityRequirements;
  final bool termsAccepted;

  // View State
  final bool isLoading;
  final String errorMessage;
  final bool isSuccess;

  const RegisterState({
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.gender = '',
    this.city = '',
    this.country = '',
    this.dietaryPreferences = '',
    this.accessibilityRequirements = '',
    this.termsAccepted = false,
    this.isLoading = false,
    this.errorMessage = '',
    this.isSuccess = false,
  });

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? gender,
    String? city,
    String? country,
    String? dietaryPreferences,
    String? accessibilityRequirements,
    bool? termsAccepted,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      country: country ?? this.country,
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
      accessibilityRequirements: accessibilityRequirements ?? this.accessibilityRequirements,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// ═════════════════════════════════════════════════════

class RegisterViewModel extends StateNotifier<RegisterState> {
  RegisterViewModel() : super(const RegisterState());

  // Form Updating functions
  void updateFullName(String val) => state = state.copyWith(fullName: val);
  void updateEmail(String val) => state = state.copyWith(email: val);
  void updatePhoneNumber(String val) => state = state.copyWith(phoneNumber: val);
  void updateGender(String val) => state = state.copyWith(gender: val);
  void updateCity(String val) => state = state.copyWith(city: val);
  void updateCountry(String val) => state = state.copyWith(country: val);
  void updateDietary(String val) => state = state.copyWith(dietaryPreferences: val);
  void updateAccessibility(String val) => state = state.copyWith(accessibilityRequirements: val);
  void updateTerms(bool val) => state = state.copyWith(termsAccepted: val);

  // ── Register Method ─────────────────────────────────
  // Submits form (Simulates saving UserModel and RegistrationModel)
  Future<void> submitRegistration() async {
    // Basic validation
    if (state.fullName.isEmpty || state.email.isEmpty || !state.termsAccepted) {
      state = state.copyWith(errorMessage: 'Please fill all required fields and accept terms.');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // Simulate network call
      await Future.delayed(const Duration(seconds: 2));

      // Successfully "created" dummy UserModel
      /*
      final newUser = UserModel(
        userId: 'U${DateTime.now().millisecondsSinceEpoch}',
        email: state.email,
        userType: 'attendee',
        fullName: state.fullName,
        phoneNumber: state.phoneNumber,
        gender: state.gender,
        city: state.city,
        country: state.country,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActive: DateTime.now(),
      );
      */

      // Successfully "created" dummy RegistrationModel (Commented out to avoid unused variable warning)
      /* 
      final newRegistration = RegistrationModel(
        registrationId: 'REG${DateTime.now().millisecondsSinceEpoch}',
        eventId: 'EVT001',
        userId: newUser.userId,
        organizerId: 'O001',
        status: 'pending',
        amountPaid: 0,
        currency: 'PKR',
        paymentStatus: 'pending',
        checkedIn: false,
      );
      */

      // TODO: Actually save these objects somewhere (like a simulated backend)

      state = state.copyWith(
        isLoading: false,
        isSuccess: true, // indicates success to UI
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Registration failed. Please try again.',
      );
    }
  }

  void resetSuccess() {
    state = state.copyWith(isSuccess: false);
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// ═════════════════════════════════════════════════════

final registerProvider = StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
  return RegisterViewModel();
});
