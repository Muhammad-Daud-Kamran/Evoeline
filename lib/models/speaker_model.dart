// lib/models/speaker_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is the MODEL for Speaker Profile (Screen 30).
// Although speakers are just an array inside the Events
// collection (Schema 3.2), we need a clean object to 
// hold their data and their related sessions/events.
//
// RULE: NO logic here — ONLY data fields.
// ─────────────────────────────────────────────────────

// Helper class for a Speaker's Upcoming Session
class SpeakerSessionData {
  final String title;
  final String dateTime;
  final String imagePath;
  final bool isLive;

  const SpeakerSessionData({
    required this.title,
    required this.dateTime,
    required this.imagePath,
    required this.isLive,
  });
}

// Helper class for a Speaker's Past Event
class SpeakerPastEventData {
  final String title;
  final String year;
  final String imagePath;

  const SpeakerPastEventData({
    required this.title,
    required this.year,
    required this.imagePath,
  });
}

class SpeakerModel {
  // ── Core Speaker Details (From Schema's Event.speakers) ────
  final String speakerId;
  final String name;
  final String designation;
  final String bio;
  final String profileImage;

  // ── Extra Social Links (Seen in UI) ────────────────────────
  final String linkedinUrl;
  final String twitterUrl;
  final String websiteUrl;

  // ── Aggregated Data (ViewModel finds these) ────────────────
  final List<SpeakerSessionData> sessions;
  final List<SpeakerPastEventData> pastEvents;

  const SpeakerModel({
    this.speakerId = '',
    this.name = '',
    this.designation = '',
    this.bio = '',
    this.profileImage = '',
    this.linkedinUrl = '',
    this.twitterUrl = '',
    this.websiteUrl = '',
    this.sessions = const [],
    this.pastEvents = const [],
  });

  // Returns empty model before data loads
  factory SpeakerModel.empty() {
    return const SpeakerModel();
  }

  // Used for updating specific fields
  SpeakerModel copyWith({
    String? speakerId,
    String? name,
    String? designation,
    String? bio,
    String? profileImage,
    String? linkedinUrl,
    String? twitterUrl,
    String? websiteUrl,
    List<SpeakerSessionData>? sessions,
    List<SpeakerPastEventData>? pastEvents,
  }) {
    return SpeakerModel(
      speakerId: speakerId ?? this.speakerId,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      twitterUrl: twitterUrl ?? this.twitterUrl,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      sessions: sessions ?? this.sessions,
      pastEvents: pastEvents ?? this.pastEvents,
    );
  }
}
