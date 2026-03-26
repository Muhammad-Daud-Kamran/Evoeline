// lib/viewmodels/attendees_viewmodel.dart

// ─────────────────────────────────────────────────────
// ViewModel for Screen 27 — Attendees List
//
// DATA SOURCES:
//   registrations/:registrationId → status, payment, checkIn
//   users/:userId                 → name, email, avatar
//
// PREVIOUS MODELS USED:
//   EventModel    → eventId for context (from eventProvider)
//   UserModel     → attendee name, email, avatar (new)
//   RegistrationModel → status, payment, checkIn (new)
//   AttendeeItemModel → combines both for display (new)
//
// FILTERS:
//   All        → all registrations
//   Registered → status = confirmed
//   Checked In → checkIn.checkedIn = true
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/user_model.dart';
import '../models/registration_models/registration_model.dart';
import '../models/attendee_item_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════

class AttendeesState {
  // All attendees loaded from registrations + users join
  final List<AttendeeItemModel> allAttendees;

  // Filtered list — shown in screen based on active filter + search
  final List<AttendeeItemModel> filteredAttendees;

  // Active filter tab
  // 'All' | 'Registered' | 'Checked In'
  final String activeFilter;

  // Current search query
  final String searchQuery;

  // Stat card values
  // Schema: count of registrations per status

  // Total count of all registrations
  final int totalRegistered; // schema: count of registrations

  // Count where checkIn.checkedIn = true
  final int checkedInCount; // schema: checkIn.checkedIn

  // Count where status = no_show
  final int noShowCount; // schema: status = no_show

  final bool isLoading;
  final String errorMessage;

  const AttendeesState({
    this.allAttendees = const [],
    this.filteredAttendees = const [],
    this.activeFilter = 'All',
    this.searchQuery = '',
    this.totalRegistered = 0,
    this.checkedInCount = 0,
    this.noShowCount = 0,
    this.isLoading = false,
    this.errorMessage = '',
  });

  AttendeesState copyWith({
    List<AttendeeItemModel>? allAttendees,
    List<AttendeeItemModel>? filteredAttendees,
    String? activeFilter,
    String? searchQuery,
    int? totalRegistered,
    int? checkedInCount,
    int? noShowCount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AttendeesState(
      allAttendees: allAttendees ?? this.allAttendees,
      filteredAttendees: filteredAttendees ?? this.filteredAttendees,
      activeFilter: activeFilter ?? this.activeFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      totalRegistered: totalRegistered ?? this.totalRegistered,
      checkedInCount: checkedInCount ?? this.checkedInCount,
      noShowCount: noShowCount ?? this.noShowCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// ═════════════════════════════════════════════════════

class AttendeesViewModel extends StateNotifier<AttendeesState> {
  AttendeesViewModel() : super(const AttendeesState(isLoading: true)) {
    loadAttendees();
  }

  // ── Load Attendees ─────────────────────────────────
  // Joins registrations + users data
  // Replace with Firestore later:
  //
  // Step 1: get all registrations for this event
  // final regSnap = await FirebaseFirestore.instance
  //     .collection('registrations')
  //     .where('eventId', isEqualTo: 'EVT001')
  //     .get();
  //
  // Step 2: for each registration, get the user
  // for each reg → get users/:userId
  //
  // Step 3: combine into AttendeeItemModel
  Future<void> loadAttendees() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Get dummy data for both collections
      final users = _getDummyUsers();
      final registrations = _getDummyRegistrations();

      // Join users + registrations → AttendeeItemModel list
      // This simulates what Firestore JOIN would do
      final attendees = registrations.map((reg) {
        // Find the matching user for this registration
        final user = users.firstWhere(
          (u) => u.userId == reg.userId,
          orElse: () => UserModel.empty(),
        );
        // Combine into display model
        return AttendeeItemModel.fromModels(
          user: user,
          registration: reg,
        );
      }).toList();

      // Calculate stat card values
      // Schema: count registrations by status
      final totalRegistered = registrations.length;

      // Count where checkIn.checkedIn = true
      // Schema: registrations.checkIn.checkedIn
      final checkedInCount = registrations.where((r) => r.checkedIn).length;

      // Count where status = no_show
      // Schema: registrations.status = no_show
      final noShowCount = registrations.where((r) => r.status == 'no_show').length;

      state = state.copyWith(
        allAttendees: attendees,
        filteredAttendees: attendees, // start with all shown
        totalRegistered: totalRegistered,
        checkedInCount: checkedInCount,
        noShowCount: noShowCount,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load attendees.',
      );
    }
  }

  // ── Filter Attendees ───────────────────────────────
  // Called when user taps All / Registered / Checked In chip
  void filterAttendees(String filter) {
    // Start from full list
    List<AttendeeItemModel> filtered;

    switch (filter) {
      case 'Registered':
        // show only confirmed registrations
        filtered = state.allAttendees.where((a) => a.statusText == 'Confirmed').toList();
        break;
      case 'Checked In':
        // show only checked in attendees
        filtered = state.allAttendees.where((a) => a.isCheckedIn).toList();
        break;
      case 'All':
      default:
        filtered = state.allAttendees;
    }

    // Also apply existing search query if any
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered
          .where((a) =>
              a.name.toLowerCase().contains(
                    state.searchQuery.toLowerCase(),
                  ) ||
              a.email.toLowerCase().contains(
                    state.searchQuery.toLowerCase(),
                  ))
          .toList();
    }

    state = state.copyWith(
      activeFilter: filter,
      filteredAttendees: filtered,
    );
  }

  // ── Search Attendees ───────────────────────────────
  // Called when user types in search box
  void searchAttendees(String query) {
    // Start from full list then apply active filter
    List<AttendeeItemModel> filtered = state.allAttendees;

    // Apply active filter first
    if (state.activeFilter == 'Registered') {
      filtered = filtered.where((a) => a.statusText == 'Confirmed').toList();
    } else if (state.activeFilter == 'Checked In') {
      filtered = filtered.where((a) => a.isCheckedIn).toList();
    }

    // Then apply search
    if (query.isNotEmpty) {
      filtered = filtered
          .where((a) =>
              a.name.toLowerCase().contains(query.toLowerCase()) ||
              a.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    state = state.copyWith(
      searchQuery: query,
      filteredAttendees: filtered,
    );
  }

  // ── Dummy Users Data ───────────────────────────────
  // Schema: users/:userId
  // Remove when Firebase is connected
  List<UserModel> _getDummyUsers() {
    return [
      UserModel(
        userId: 'U001',
        email: 'olivia.smith@email.com',
        userType: 'attendee',
        fullName: 'Olivia Smith',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActive: DateTime.now(),
      ),
      UserModel(
        userId: 'U002',
        email: 'liam.johnson@email.com',
        userType: 'attendee',
        fullName: 'Liam Johnson',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActive: DateTime.now(),
      ),
      UserModel(
        userId: 'U003',
        email: 'emma.brown@email.com',
        userType: 'attendee',
        fullName: 'Emma Brown',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActive: DateTime.now(),
      ),
      UserModel(
        userId: 'U004',
        email: 'noah.davis@email.com',
        userType: 'attendee',
        fullName: 'Noah Davis',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActive: DateTime.now(),
      ),
      UserModel(
        userId: 'U005',
        email: 'sophia.rodriguez@email.com',
        userType: 'attendee',
        fullName: 'Sophia Rodriguez',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActive: DateTime.now(),
      ),
    ];
  }

  // ── Dummy Registrations Data ───────────────────────
  // Schema: registrations/:registrationId
  // Remove when Firebase is connected
  List<RegistrationModel> _getDummyRegistrations() {
    return const [
      RegistrationModel(
        registrationId: 'REG001',
        eventId: 'EVT001',
        userId: 'U001',
        organizerId: 'U002',
        // Schema: status
        status: 'checked_in',
        // Schema: payment.*
        amountPaid: 1500,
        currency: 'PKR',
        paymentMethod: 'jazzcash',
        paymentStatus: 'completed', // isPaid = true
        pricingTier: 'Early Bird',
        finalPrice: 1500,
        // Schema: checkIn.*
        checkedIn: true,
        checkInMethod: 'qr_scan',
      ),
      RegistrationModel(
        registrationId: 'REG002',
        eventId: 'EVT001',
        userId: 'U002',
        organizerId: 'U002',
        status: 'confirmed',
        amountPaid: 2000,
        currency: 'PKR',
        paymentMethod: 'easypaisa',
        paymentStatus: 'completed',
        pricingTier: 'Regular',
        finalPrice: 2000,
        checkedIn: true,
        checkInMethod: 'qr_scan',
      ),
      RegistrationModel(
        registrationId: 'REG003',
        eventId: 'EVT001',
        userId: 'U003',
        organizerId: 'U002',
        status: 'confirmed',
        amountPaid: 1500,
        currency: 'PKR',
        paymentMethod: 'jazzcash',
        paymentStatus: 'completed',
        pricingTier: 'Early Bird',
        finalPrice: 1500,
        checkedIn: false, // not checked in yet
      ),
      RegistrationModel(
        registrationId: 'REG004',
        eventId: 'EVT001',
        userId: 'U004',
        organizerId: 'U002',
        // Schema: status = pending
        status: 'pending',
        amountPaid: 0,
        currency: 'PKR',
        paymentStatus: 'pending', // isPaid = false → Unpaid
        checkedIn: false,
      ),
      RegistrationModel(
        registrationId: 'REG005',
        eventId: 'EVT001',
        userId: 'U005',
        organizerId: 'U002',
        status: 'checked_in',
        amountPaid: 2000,
        currency: 'PKR',
        paymentMethod: 'jazzcash',
        paymentStatus: 'completed',
        pricingTier: 'Regular',
        finalPrice: 2000,
        checkedIn: true,
        checkInMethod: 'qr_scan',
      ),
    ];
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// ═════════════════════════════════════════════════════

final attendeesProvider = StateNotifierProvider<AttendeesViewModel, AttendeesState>(
  (ref) => AttendeesViewModel(),
);
