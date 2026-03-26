// lib/models/vendor_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// Complete VendorModel matching the `vendors` collection
// from the EventFlow schema (section 3.5).
//
// SCHEMA FIELDS:
//   vendorId, businessName, contact, serviceCategories,
//   portfolio, pricingPackages, ratings, stats,
//   verification, settings, status, featured, timestamps.
//
// RULE: NO logic here — ONLY data fields + empty() + copyWith()
// ─────────────────────────────────────────────────────

class VendorModel {
  // ── Core Identity ──────────────────────────────────
  // Schema: vendors.vendorId, userId, businessName, status
  final String vendorId;
  final String userId;          // reference to users/
  final String businessName;
  final String status;          // active | inactive | suspended

  // ── Contact Information ────────────────────────────
  // Schema: vendors.contact.*
  final String primaryPhone;
  final String secondaryPhone;
  final String businessEmail;
  final String website;
  final String addressStreet;
  final String addressCity;
  final String addressCountry;

  // ── Service Categories ─────────────────────────────
  // Schema: vendors.serviceCategories[]
  final List<String> serviceCategories;

  // ── Ratings & Reviews ──────────────────────────────
  // Schema: vendors.ratings.*
  final double averageRating;
  final int totalReviews;

  // ── Business Stats ─────────────────────────────────
  // Schema: vendors.stats.*
  final int totalBookings;
  final int completedBookings;
  final int repeatClients;
  final double totalRevenue;

  // ── Verification & Trust ───────────────────────────
  // Schema: vendors.verification.*
  final bool isVerified;
  final List<String> verificationBadges; // e.g., ["top_rated", "fast_response"]

  // ── Flags for UI ───────────────────────────────────
  // Schema: vendors.featured
  final bool isFeatured;

  // ── Visuals (from portfolio or profile) ────────────
  // Not a top-level field, but we can use the first portfolio image
  final String logoImage;       // placeholder for card image

  // ── Timestamps (optional) ──────────────────────────
  final String createdAt;
  final String updatedAt;
  final String lastActive;

  const VendorModel({
    required this.vendorId,
    required this.userId,
    required this.businessName,
    this.status = 'active',
    this.primaryPhone = '',
    this.secondaryPhone = '',
    this.businessEmail = '',
    this.website = '',
    this.addressStreet = '',
    this.addressCity = '',
    this.addressCountry = '',
    this.serviceCategories = const [],
    this.averageRating = 0.0,
    this.totalReviews = 0,
    this.totalBookings = 0,
    this.completedBookings = 0,
    this.repeatClients = 0,
    this.totalRevenue = 0.0,
    this.isVerified = false,
    this.verificationBadges = const [],
    this.isFeatured = false,
    this.logoImage = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.lastActive = '',
  });

  // ── empty() ────────────────────────────────────────
  factory VendorModel.empty() => const VendorModel(
    vendorId: '',
    userId: '',
    businessName: '',
  );

  // ── copyWith() ─────────────────────────────────────
  VendorModel copyWith({
    String? vendorId,
    String? userId,
    String? businessName,
    String? status,
    String? primaryPhone,
    String? secondaryPhone,
    String? businessEmail,
    String? website,
    String? addressStreet,
    String? addressCity,
    String? addressCountry,
    List<String>? serviceCategories,
    double? averageRating,
    int? totalReviews,
    int? totalBookings,
    int? completedBookings,
    int? repeatClients,
    double? totalRevenue,
    bool? isVerified,
    List<String>? verificationBadges,
    bool? isFeatured,
    String? logoImage,
    String? createdAt,
    String? updatedAt,
    String? lastActive,
  }) {
    return VendorModel(
      vendorId: vendorId ?? this.vendorId,
      userId: userId ?? this.userId,
      businessName: businessName ?? this.businessName,
      status: status ?? this.status,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      secondaryPhone: secondaryPhone ?? this.secondaryPhone,
      businessEmail: businessEmail ?? this.businessEmail,
      website: website ?? this.website,
      addressStreet: addressStreet ?? this.addressStreet,
      addressCity: addressCity ?? this.addressCity,
      addressCountry: addressCountry ?? this.addressCountry,
      serviceCategories: serviceCategories ?? this.serviceCategories,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      totalBookings: totalBookings ?? this.totalBookings,
      completedBookings: completedBookings ?? this.completedBookings,
      repeatClients: repeatClients ?? this.repeatClients,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      isVerified: isVerified ?? this.isVerified,
      verificationBadges: verificationBadges ?? this.verificationBadges,
      isFeatured: isFeatured ?? this.isFeatured,
      logoImage: logoImage ?? this.logoImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}