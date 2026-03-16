// lib/models/discount_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is the MODEL for ONE discount setting
// We use it for BOTH student discount AND group discount
// Same model, two different usages
//
// WHERE DOES IT COME FROM IN SCHEMA?
// events/:eventId → pricing → studentDiscount
// events/:eventId → pricing → groupDiscount
//
// RULE: NO logic here. ONLY data fields.
// ─────────────────────────────────────────────────────

class DiscountModel {

  final bool   isEnabled;            // is this discount turned on
  final int    percentage;           // 20 (means 20%)
  final bool   requiresVerification; // student must verify .edu email
  final int    minGroupSize;         // group discount: need min 5 people

  // Constructor with default values
  // Using const because this object never changes itself
  const DiscountModel({
    this.isEnabled            = false,
    this.percentage           = 0,
    this.requiresVerification = false,
    this.minGroupSize         = 2,
  });

  // copyWith() — used when organizer toggles or changes a value
  DiscountModel copyWith({
    bool? isEnabled,
    int?  percentage,
    bool? requiresVerification,
    int?  minGroupSize,
  }) {
    return DiscountModel(
      isEnabled:            isEnabled            ?? this.isEnabled,
      percentage:           percentage           ?? this.percentage,
      requiresVerification: requiresVerification ?? this.requiresVerification,
      minGroupSize:         minGroupSize         ?? this.minGroupSize,
    );
  }
}