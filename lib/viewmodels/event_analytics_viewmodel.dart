// lib/viewmodels/event_analytics_viewmodel.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is the VIEWMODEL for Screen 29 (Event Analytics).
// It manages the state (loading, error, data) and handles
// fetching data. It currently uses DUMMY DATA.
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/event_analytics_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════
class EventAnalyticsState {
  final EventAnalyticsModel analytics;
  final bool isLoading;
  final String errorMessage;

  const EventAnalyticsState({
    required this.analytics,
    this.isLoading = false,
    this.errorMessage = '',
  });

  EventAnalyticsState copyWith({
    EventAnalyticsModel? analytics,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EventAnalyticsState(
      analytics: analytics ?? this.analytics,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// ═════════════════════════════════════════════════════
class EventAnalyticsViewModel extends StateNotifier<EventAnalyticsState> {
  EventAnalyticsViewModel()
      : super(EventAnalyticsState(
          analytics: EventAnalyticsModel.empty(),
          isLoading: true, // Start in a loading state
        )) {
    // Automatically load data when ViewModel is initialized
    loadEventAnalytics('EVT001'); // Using dummy event ID for now
  }

  // ── Load Data ──────────────────────────────────────
  Future<void> loadEventAnalytics(String eventId) async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // Simulate network delay (e.g., fetching from Firestore)
      await Future.delayed(const Duration(milliseconds: 1000));

      // In the future: Fetch from Events, Registrations, and Reviews collections
      // using the provided eventId.
      
      // Update state with dummy data
      state = state.copyWith(
        analytics: _getDummyData(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load event analytics.',
      );
    }
  }

  // ── Dummy Data ─────────────────────────────────────
  // This matches exactly what is shown in the UI mockup for Screen 29
  EventAnalyticsModel _getDummyData() {
    return const EventAnalyticsModel(
      eventName: 'Advanced Flutter & Firebase Workshop', // Replaced "Event Name"
      eventLocation: 'NED University Auditorium', // Replaced "123 Main St, Anytown"
      
      registrationRate: 0.85, 
      registrationRateChange: '+5%',
      attendanceRate: 0.78,
      attendanceRateChange: '-2%',
      satisfactionScore: 4.5,
      satisfactionScoreChange: '+1%',
      roiPercentage: 0.15,
      roiPercentageChange: '+3%',

      totalRegistrations: 1200,
      registrationTimelineChange: '+10%',
      totalCheckIns: 900,
      checkInTimelineChange: '-5%',

      demographics: [
        DemographicData(label: '18-24', percentage: 0.15),
        DemographicData(label: '25-34', percentage: 0.40),
        DemographicData(label: '35-44', percentage: 0.25),
        DemographicData(label: '45+', percentage: 0.20),
      ],

      registrationSources: [
        RegistrationSourceData(label: 'LinkedIn', percentage: 0.30),
        RegistrationSourceData(label: 'WhatsApp', percentage: 0.60),
        RegistrationSourceData(label: 'Direct', percentage: 0.45),
        RegistrationSourceData(label: 'Other', percentage: 0.40),
      ],

      overallRating: 4.5,
      sentimentPositivePercentage: 70,
      sentimentNeutralPercentage: 20,
      sentimentNegativePercentage: 10,
      keyTakeaways: [
        'Insight 1: High satisfaction with speakers.',
        'Insight 2: Need more networking opportunities.'
      ],
    );
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// ═════════════════════════════════════════════════════
// This is what the UI (Screen 29) uses to watch the state
final eventAnalyticsProvider = StateNotifierProvider<EventAnalyticsViewModel, EventAnalyticsState>((ref) {
  return EventAnalyticsViewModel();
});
