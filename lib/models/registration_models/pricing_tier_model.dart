// lib/models/pricing_tier_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is the MODEL for ONE pricing tier
// Example: Early Bird → 1500 PKR → 30 seats → until March 15
//
// WHERE DOES IT COME FROM IN SCHEMA?
// events/:eventId → pricing → tiers[]
//
// RULE: NO logic here. ONLY data fields.
// ─────────────────────────────────────────────────────

class PricingTierModel {
  // Every tier has these 5 fields — matching the schema exactly
  final String id; // unique ID like T001, T002
  final String name; // Early Bird | Regular | VIP
  final double price; // 1500.0
  final String availableUntil; // "2024-03-15"
  final int seats; // 30

  // Constructor — how you create a PricingTierModel object
  const PricingTierModel({
    required this.id,
    required this.name,
    required this.price,
    required this.availableUntil,
    required this.seats,
  });

  // copyWith() — update ONE field without changing others
  // Example: tier.copyWith(price: 2000)
  // Used when organizer edits a tier
  PricingTierModel copyWith({
    String? name,
    double? price,
    String? availableUntil,
    int? seats,
  }) {
    return PricingTierModel(
      id: id, // id never changes
      name: name ?? this.name,
      price: price ?? this.price,
      availableUntil: availableUntil ?? this.availableUntil,
      seats: seats ?? this.seats,
    );
  }
}
