// lib/viewmodels/generate_certificates_viewmodel.dart

// ─────────────────────────────────────────────────────
// ViewModel for Screen 34 — Generate Certificates
//
// Manages the state for certificate generation, including:
// - Selected attendees
// - Template choice
// - Signatory details
// - Associated skills
// - Blockchain toggles
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/legacy.dart';

import '../models/attendee_item_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════

class GenerateCertificatesState {
  final List<AttendeeItemModel> attendees;
  final Set<String> selectedAttendeeIds;

  final String selectedTemplate; // 'Modern', 'Classic', 'Minimal'
  final String signatoryName;
  final String signatoryTitle;
  final List<String> skills;
  final String customMessage;

  final bool isBlockchainEnabled;
  final String network;

  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  const GenerateCertificatesState({
    this.attendees = const [],
    this.selectedAttendeeIds = const {},
    this.selectedTemplate = 'Modern',
    this.signatoryName = '',
    this.signatoryTitle = '',
    this.skills = const ['Leadership', 'Communication', 'Teamwork'],
    this.customMessage = '',
    this.isBlockchainEnabled = false,
    this.network = 'Polygon',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  GenerateCertificatesState copyWith({
    List<AttendeeItemModel>? attendees,
    Set<String>? selectedAttendeeIds,
    String? selectedTemplate,
    String? signatoryName,
    String? signatoryTitle,
    List<String>? skills,
    String? customMessage,
    bool? isBlockchainEnabled,
    String? network,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return GenerateCertificatesState(
      attendees: attendees ?? this.attendees,
      selectedAttendeeIds: selectedAttendeeIds ?? this.selectedAttendeeIds,
      selectedTemplate: selectedTemplate ?? this.selectedTemplate,
      signatoryName: signatoryName ?? this.signatoryName,
      signatoryTitle: signatoryTitle ?? this.signatoryTitle,
      skills: skills ?? this.skills,
      customMessage: customMessage ?? this.customMessage,
      isBlockchainEnabled: isBlockchainEnabled ?? this.isBlockchainEnabled,
      network: network ?? this.network,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// ═════════════════════════════════════════════════════

class GenerateCertificatesViewModel extends StateNotifier<GenerateCertificatesState> {
  GenerateCertificatesViewModel() : super(const GenerateCertificatesState()) {
    loadAttendees();
  }

  // ── Load Dummy Attendees ───────────────────────────
  Future<void> loadAttendees() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Same dummy attendees pattern mapping users + registrations
      final mockAttendees = [
        AttendeeItemModel(
          name: 'Olivia Smith',
          email: 'olivia.smith@email.com',
          avatarImagePath: '',
          isCheckedIn: true,
          statusText: 'Checked In',
          paymentStatus: 'Paid',
          paymentAmount: 'PKR 1500',
          userId: 'U001',
          registrationId: 'REG001',
        ),
        AttendeeItemModel(
          name: 'Liam Johnson',
          email: 'liam.johnson@email.com',
          avatarImagePath: '',
          isCheckedIn: true,
          statusText: 'Checked In',
          paymentStatus: 'Paid',
          paymentAmount: 'PKR 2000',
          userId: 'U002',
          registrationId: 'REG002',
        ),
        AttendeeItemModel(
          name: 'Emma Williams',
          email: 'emma.williams@email.com',
          avatarImagePath: '',
          isCheckedIn: true,
          statusText: 'Checked In',
          paymentStatus: 'Paid',
          paymentAmount: 'PKR 1500',
          userId: 'U003',
          registrationId: 'REG003',
        ),
        AttendeeItemModel(
          name: 'Noah Brown',
          email: 'noah.brown@email.com',
          avatarImagePath: '',
          isCheckedIn: false,
          statusText: 'Pending',
          paymentStatus: 'Unpaid',
          paymentAmount: '',
          userId: 'U004',
          registrationId: 'REG004',
        ),
        AttendeeItemModel(
          name: 'Ava Davis',
          email: 'ava.davis@email.com',
          avatarImagePath: '',
          isCheckedIn: true,
          statusText: 'Checked In',
          paymentStatus: 'Paid',
          paymentAmount: 'PKR 2000',
          userId: 'U005',
          registrationId: 'REG005',
        ),
      ];

      state = state.copyWith(
        attendees: mockAttendees,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load attendees',
      );
    }
  }

  // ── Selections & Toggles ───────────────────────────

  void toggleAttendeeSelection(String userId) {
    final newSelection = Set<String>.from(state.selectedAttendeeIds);
    if (newSelection.contains(userId)) {
      newSelection.remove(userId);
    } else {
      newSelection.add(userId);
    }
    state = state.copyWith(selectedAttendeeIds: newSelection);
  }

  void selectAllAttendees() {
    final allIds = state.attendees.map((a) => a.userId).toSet();
    state = state.copyWith(selectedAttendeeIds: allIds);
  }

  void selectTemplate(String template) {
    state = state.copyWith(selectedTemplate: template);
  }

  void updateSignatoryName(String name) => state = state.copyWith(signatoryName: name);
  void updateSignatoryTitle(String title) => state = state.copyWith(signatoryTitle: title);
  void updateCustomMessage(String message) => state = state.copyWith(customMessage: message);
  void toggleBlockchain(bool val) => state = state.copyWith(isBlockchainEnabled: val);
  void updateNetwork(String net) => state = state.copyWith(network: net);

  // ── Generation Logic ───────────────────────────────
  
  Future<void> generateCertificates() async {
    if (state.selectedAttendeeIds.isEmpty) {
      state = state.copyWith(errorMessage: 'Please select at least one attendee.');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      await Future.delayed(const Duration(seconds: 2));

      // Simulate generating CertificateModels for each selected attendee
      // In real scenario, it passes states to backend API
      /*
      final generatedCertificates = state.selectedAttendeeIds.map((userId) {
        return CertificateModel.empty().copyWith(
          certificateId: 'CERT_${DateTime.now().millisecondsSinceEpoch}',
          userId: userId,
          type: state.isBlockchainEnabled ? 'both' : 'digital',
          status: 'ready',
          content: {
            'template': state.selectedTemplate,
            'signatoryName': state.signatoryName,
            'signatoryTitle': state.signatoryTitle,
            'customMessage': state.customMessage,
            'skills': state.skills,
          },
        );
      }).toList();
      */

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to generate certificates.',
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

final generateCertificatesProvider = StateNotifierProvider<GenerateCertificatesViewModel, GenerateCertificatesState>((ref) {
  return GenerateCertificatesViewModel();
});
