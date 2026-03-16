// lib/models/custom_field_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is the MODEL for ONE custom field the organizer adds
// Example: "University ID" → Text field → Required
//
// WHERE DOES IT COME FROM IN SCHEMA?
// events/:eventId → registration → customForm[]
//    fieldId, label, type, options, required
//
// RULE: NO logic here. ONLY data fields.
// ─────────────────────────────────────────────────────

class CustomFieldModel {

  final String       fieldId;    // F001, F002 — unique ID
  final String       label;      // "University ID", "T-Shirt Size"
  final String       type;       // "Text" | "Dropdown" | "Checkbox"
  final bool         isRequired; // must fill or optional
  final List<String> options;    // only for Dropdown type
  // example: ["Beginner","Intermediate"]

  const CustomFieldModel({
    required this.fieldId,
    required this.label,
    required this.type,
    this.isRequired = false,
    this.options    = const [], // empty list by default
  });

  // copyWith() — used when organizer edits a field
  CustomFieldModel copyWith({
    String?       label,
    String?       type,
    bool?         isRequired,
    List<String>? options,
  }) {
    return CustomFieldModel(
      fieldId:    fieldId,          // fieldId never changes
      label:      label      ?? this.label,
      type:       type       ?? this.type,
      isRequired: isRequired ?? this.isRequired,
      options:    options    ?? this.options,
    );
  }
}