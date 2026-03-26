// lib/models/event_analytics_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is the MODEL for Event-Specific Analytics (Screen 29).
// It maps data from the Events, Registrations, and Reviews collections
// specifically focusing on a single event's performance.
//
// RULE: NO logic here — ONLY data fields.
// ─────────────────────────────────────────────────────

// Helper class for Demographic Breakdown
class DemographicData {
  final String label;
  final double percentage; // e.g., 0.15 for 15%

  const DemographicData({
    required this.label,
    required this.percentage,
  });
}

// Helper class for Registration Sources
class RegistrationSourceData {
  final String label;
  final double percentage; // e.g., 0.30 for 30%

  const RegistrationSourceData({
    required this.label,
    required this.percentage,
  });
}

class EventAnalyticsModel {
  // ── Event Info ─────────────────────────────────────
  final String eventName;
  final String eventLocation;

  // ── Top Stat Cards ─────────────────────────────────
  final double registrationRate;       // e.g., 0.85 for 85%
  final String registrationRateChange; // e.g., "+5%"
  final double attendanceRate;         // e.g., 0.78 for 78%
  final String attendanceRateChange;   // e.g., "-2%"
  final double satisfactionScore;      // e.g., 4.5
  final String satisfactionScoreChange;// e.g., "+1%"
  final double roiPercentage;          // e.g., 0.15 for 15%
  final String roiPercentageChange;    // e.g., "+3%"

  // ── Charts Data (Totals) ───────────────────────────
  final int totalRegistrations;
  final String registrationTimelineChange;
  final int totalCheckIns;
  final String checkInTimelineChange;

  // ── Breakdowns ─────────────────────────────────────
  final List<DemographicData> demographics;
  final List<RegistrationSourceData> registrationSources;

  // ── Feedback Summary ───────────────────────────────
  final double overallRating;
  final int sentimentPositivePercentage; // e.g., 70
  final int sentimentNeutralPercentage;  // e.g., 20
  final int sentimentNegativePercentage; // e.g., 10
  final List<String> keyTakeaways;

  const EventAnalyticsModel({
    this.eventName = '',
    this.eventLocation = '',
    this.registrationRate = 0.0,
    this.registrationRateChange = '0%',
    this.attendanceRate = 0.0,
    this.attendanceRateChange = '0%',
    this.satisfactionScore = 0.0,
    this.satisfactionScoreChange = '0%',
    this.roiPercentage = 0.0,
    this.roiPercentageChange = '0%',
    this.totalRegistrations = 0,
    this.registrationTimelineChange = '0%',
    this.totalCheckIns = 0,
    this.checkInTimelineChange = '0%',
    this.demographics = const [],
    this.registrationSources = const [],
    this.overallRating = 0.0,
    this.sentimentPositivePercentage = 0,
    this.sentimentNeutralPercentage = 0,
    this.sentimentNegativePercentage = 0,
    this.keyTakeaways = const [],
  });

  // Returns empty model before data loads
  factory EventAnalyticsModel.empty() {
    return const EventAnalyticsModel();
  }

  // Used for updating specific fields
  EventAnalyticsModel copyWith({
    String? eventName,
    String? eventLocation,
    double? registrationRate,
    String? registrationRateChange,
    double? attendanceRate,
    String? attendanceRateChange,
    double? satisfactionScore,
    String? satisfactionScoreChange,
    double? roiPercentage,
    String? roiPercentageChange,
    int? totalRegistrations,
    String? registrationTimelineChange,
    int? totalCheckIns,
    String? checkInTimelineChange,
    List<DemographicData>? demographics,
    List<RegistrationSourceData>? registrationSources,
    double? overallRating,
    int? sentimentPositivePercentage,
    int? sentimentNeutralPercentage,
    int? sentimentNegativePercentage,
    List<String>? keyTakeaways,
  }) {
    return EventAnalyticsModel(
      eventName: eventName ?? this.eventName,
      eventLocation: eventLocation ?? this.eventLocation,
      registrationRate: registrationRate ?? this.registrationRate,
      registrationRateChange: registrationRateChange ?? this.registrationRateChange,
      attendanceRate: attendanceRate ?? this.attendanceRate,
      attendanceRateChange: attendanceRateChange ?? this.attendanceRateChange,
      satisfactionScore: satisfactionScore ?? this.satisfactionScore,
      satisfactionScoreChange: satisfactionScoreChange ?? this.satisfactionScoreChange,
      roiPercentage: roiPercentage ?? this.roiPercentage,
      roiPercentageChange: roiPercentageChange ?? this.roiPercentageChange,
      totalRegistrations: totalRegistrations ?? this.totalRegistrations,
      registrationTimelineChange: registrationTimelineChange ?? this.registrationTimelineChange,
      totalCheckIns: totalCheckIns ?? this.totalCheckIns,
      checkInTimelineChange: checkInTimelineChange ?? this.checkInTimelineChange,
      demographics: demographics ?? this.demographics,
      registrationSources: registrationSources ?? this.registrationSources,
      overallRating: overallRating ?? this.overallRating,
      sentimentPositivePercentage: sentimentPositivePercentage ?? this.sentimentPositivePercentage,
      sentimentNeutralPercentage: sentimentNeutralPercentage ?? this.sentimentNeutralPercentage,
      sentimentNegativePercentage: sentimentNegativePercentage ?? this.sentimentNegativePercentage,
      keyTakeaways: keyTakeaways ?? this.keyTakeaways,
    );
  }
}
