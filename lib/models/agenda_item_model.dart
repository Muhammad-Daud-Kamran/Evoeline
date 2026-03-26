// lib/models/agenda_item_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// Model for ONE agenda item in an event
//
// WHERE IN SCHEMA?
// events/:eventId → agenda[]
// Schema mentions agenda as "session schedule"
// Each item is a session with title and time
//
// USED IN:
//   Screen 31 → Agenda section
//   AgendaTimelineItem widget → title, time, isLast
//
// RULE: NO logic — ONLY data fields
// ─────────────────────────────────────────────────────

class AgendaItemModel {

  // Unique ID for this agenda item
  // Not explicitly in schema but needed for list keys
  final String agendaId;

  // Session title
  // Schema: agenda[].title (implied from session schedule)
  // Example: "Opening Keynote"
  final String title;

  // Time range for this session
  // Schema: agenda[].time
  // Example: "10:00 AM - 11:00 AM"
  final String time;

  // Session description (optional)
  final String description;

  // Speaker for this session (optional)
  // Links to speakers[] in event
  final String speakerId;

  // Is this the LAST item in the agenda?
  // Controls timeline line drawing in AgendaTimelineItem
  // NOT stored in schema — computed in ViewModel
  final bool isLast;

  const AgendaItemModel({
    required this.agendaId,
    required this.title,
    required this.time,
    this.description = '',
    this.speakerId   = '',
    this.isLast      = false,
  });

  // copyWith — update one field
  AgendaItemModel copyWith({
    String? title,
    String? time,
    String? description,
    String? speakerId,
    bool?   isLast,
  }) {
    return AgendaItemModel(
      agendaId:    agendaId,
      title:       title       ?? this.title,
      time:        time        ?? this.time,
      description: description ?? this.description,
      speakerId:   speakerId   ?? this.speakerId,
      isLast:      isLast      ?? this.isLast,
    );
  }
}