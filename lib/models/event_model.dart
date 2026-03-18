// lib/models/event_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// This is the complete EventModel matching the full
// events/:eventId schema
//
// SUBMODELS USED (already created):
//   PricingTierModel  → events.pricing.tiers[]
//   DiscountModel     → events.pricing.studentDiscount
//                       events.pricing.groupDiscount
//   CustomFieldModel  → events.registration.customForm[]
//
// SpeakerModel → will be added later
//
// RULE: NO logic here. ONLY data fields + empty() + copyWith()
// ─────────────────────────────────────────────────────

import 'registration_models/pricing_tier_model.dart';
import 'registration_models/discount_model.dart';
import 'registration_models/custom_field_model.dart';

class EventModel {
  // ── SECTION 1: Core Identity ───────────────────────
  // matches: events.eventId, organizerId, title etc
  final String eventId; // EVT001, EVT002
  final String organizerId; // ref to users/
  final String title;
  final String description;
  final String shortDescription;

  // matches: events.category
  // technology | business | healthcare | education
  final String category;

  // matches: events.eventType
  // workshop | conference | seminar | webinar | hackathon
  final String eventType;

  // matches: events.format
  // physical | virtual | hybrid
  final String format;

  // matches: events.status
  // draft | published | registration_open | ongoing | completed | cancelled
  final String status;

  // matches: events.visibility
  // public | private | invite_only
  final String visibility;

  // matches: events.accessCode
  final String accessCode;

  // ── SECTION 2: Media ──────────────────────────────
  // matches: events.bannerImage
  final String bannerImage;

  // matches: events.galleryImages[]
  final List<String> galleryImages;

  // matches: events.promoVideoUrl
  final String promoVideoUrl;

  // ── SECTION 3: Schedule ───────────────────────────
  // kept FLAT — simple string fields, no submodel needed
  // matches: events.schedule.*

  final String startDate; // "2024-04-15"
  final String endDate; // "2024-04-16"
  final String startTime; // "10:00 AM"
  final String endTime; // "5:00 PM"
  final String timezone; // "PKT"
  final bool isRecurring;
  final String recurrencePattern; // weekly | monthly | null

  // ── SECTION 4: Location ───────────────────────────
  // kept FLAT — no submodel needed
  // matches: events.location.*

  // Physical location
  final String venueName;
  final String address;
  final String city;
  final String country;
  final double latitude;
  final double longitude;

  // Virtual location
  final String meetingPlatform; // Google Meet | Zoom | Teams
  final String meetingLink;
  final String meetingId;
  final String meetingPassword;

  // ── SECTION 5: Capacity ───────────────────────────
  // kept FLAT — only 3 int fields, no submodel needed
  // matches: events.capacity.*

  final int totalSeats;
  final int reservedSeats; // for VIPs/speakers
  final int availableSeats;

  // ── SECTION 6: Registration ───────────────────────
  // matches: events.registration.*

  final String registrationOpenDate;
  final String registrationCloseDate;
  final bool requiresApproval;

  // Custom form fields → submodel because complex + reused
  // matches: events.registration.customForm[]
  final List<CustomFieldModel> customFields;

  // ── SECTION 7: Pricing ────────────────────────────
  // matches: events.pricing.*

  final bool isFree;
  final String currency; // PKR

  // Pricing tiers → submodel because complex + reused in 3 screens
  // matches: events.pricing.tiers[]
  final List<PricingTierModel> tiers;

  // Discounts → submodel because has isEnabled logic + reused
  // matches: events.pricing.studentDiscount
  final DiscountModel studentDiscount;

  // matches: events.pricing.groupDiscount
  final DiscountModel groupDiscount;

  // ── SECTION 8: Certificate Config ─────────────────
  // kept FLAT — simple fields, only used in Screen 24
  // matches: events.certificateConfig.*

  final bool issueCertificates;

  // digital | blockchain | both
  final String certificateType;
  final String templateId;

  // requirements
  final int minAttendance; // percentage e.g. 80
  final bool mustCompleteSurvey;

  // ── SECTION 9: Analytics ──────────────────────────
  // read only — kept FLAT — no submodel needed
  // matches: events.analytics.*

  final int views;
  final int registrations;
  final int checkIns;
  final double completionRate;
  final double revenue;

  // ── SECTION 10: Timestamps ────────────────────────
  final String createdAt;
  final String updatedAt;
  final String publishedAt;

  // ── Constructor ───────────────────────────────────
  const EventModel({
    // Core
    required this.eventId,
    required this.organizerId,
    required this.title,
    required this.description,
    this.shortDescription = '',
    required this.category,
    required this.eventType,
    required this.format,
    required this.status,
    this.visibility = 'public',
    this.accessCode = '',

    // Media
    required this.bannerImage,
    this.galleryImages = const [],
    this.promoVideoUrl = '',

    // Schedule
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.timezone = 'PKT',
    this.isRecurring = false,
    this.recurrencePattern = '',

    // Location
    required this.venueName,
    this.address = '',
    this.city = '',
    this.country = 'Pakistan',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.meetingPlatform = '',
    this.meetingLink = '',
    this.meetingId = '',
    this.meetingPassword = '',

    // Capacity
    required this.totalSeats,
    this.reservedSeats = 0,
    required this.availableSeats,

    // Registration
    this.registrationOpenDate = '',
    this.registrationCloseDate = '',
    this.requiresApproval = false,
    this.customFields = const [],

    // Pricing
    required this.isFree,
    this.currency = 'PKR',
    this.tiers = const [],
    this.studentDiscount = const DiscountModel(),
    this.groupDiscount = const DiscountModel(),

    // Certificates
    this.issueCertificates = false,
    this.certificateType = 'digital',
    this.templateId = '',
    this.minAttendance = 80,
    this.mustCompleteSurvey = false,

    // Analytics
    this.views = 0,
    this.registrations = 0,
    this.checkIns = 0,
    this.completionRate = 0.0,
    this.revenue = 0.0,

    // Timestamps
    this.createdAt = '',
    this.updatedAt = '',
    this.publishedAt = '',
  });

  // ── empty() ───────────────────────────────────────
  // Used when creating a brand new event from scratch
  factory EventModel.empty() {
    return const EventModel(
      eventId: '',
      organizerId: '',
      title: '',
      description: '',
      category: '',
      eventType: '',
      format: 'physical',
      status: 'draft',
      bannerImage: '',
      startDate: '',
      endDate: '',
      startTime: '',
      endTime: '',
      venueName: '',
      totalSeats: 0,
      availableSeats: 0,
      isFree: true,
    );
  }

  // ── copyWith() ────────────────────────────────────
  // Updates ONE field without changing the rest
  // REQUIRED by Riverpod — needs a new object on every change
  EventModel copyWith({
    String? eventId,
    String? organizerId,
    String? title,
    String? description,
    String? shortDescription,
    String? category,
    String? eventType,
    String? format,
    String? status,
    String? visibility,
    String? accessCode,
    String? bannerImage,
    List<String>? galleryImages,
    String? promoVideoUrl,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    String? timezone,
    bool? isRecurring,
    String? recurrencePattern,
    String? venueName,
    String? address,
    String? city,
    String? country,
    double? latitude,
    double? longitude,
    String? meetingPlatform,
    String? meetingLink,
    String? meetingId,
    String? meetingPassword,
    int? totalSeats,
    int? reservedSeats,
    int? availableSeats,
    String? registrationOpenDate,
    String? registrationCloseDate,
    bool? requiresApproval,
    List<CustomFieldModel>? customFields,
    bool? isFree,
    String? currency,
    List<PricingTierModel>? tiers,
    DiscountModel? studentDiscount,
    DiscountModel? groupDiscount,
    bool? issueCertificates,
    String? certificateType,
    String? templateId,
    int? minAttendance,
    bool? mustCompleteSurvey,
    int? views,
    int? registrations,
    int? checkIns,
    double? completionRate,
    double? revenue,
    String? createdAt,
    String? updatedAt,
    String? publishedAt,
  }) {
    return EventModel(
      eventId: eventId ?? this.eventId,
      organizerId: organizerId ?? this.organizerId,
      title: title ?? this.title,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      category: category ?? this.category,
      eventType: eventType ?? this.eventType,
      format: format ?? this.format,
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      accessCode: accessCode ?? this.accessCode,
      bannerImage: bannerImage ?? this.bannerImage,
      galleryImages: galleryImages ?? this.galleryImages,
      promoVideoUrl: promoVideoUrl ?? this.promoVideoUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timezone: timezone ?? this.timezone,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrencePattern: recurrencePattern ?? this.recurrencePattern,
      venueName: venueName ?? this.venueName,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      meetingPlatform: meetingPlatform ?? this.meetingPlatform,
      meetingLink: meetingLink ?? this.meetingLink,
      meetingId: meetingId ?? this.meetingId,
      meetingPassword: meetingPassword ?? this.meetingPassword,
      totalSeats: totalSeats ?? this.totalSeats,
      reservedSeats: reservedSeats ?? this.reservedSeats,
      availableSeats: availableSeats ?? this.availableSeats,
      registrationOpenDate: registrationOpenDate ?? this.registrationOpenDate,
      registrationCloseDate:
          registrationCloseDate ?? this.registrationCloseDate,
      requiresApproval: requiresApproval ?? this.requiresApproval,
      customFields: customFields ?? this.customFields,
      isFree: isFree ?? this.isFree,
      currency: currency ?? this.currency,
      tiers: tiers ?? this.tiers,
      studentDiscount: studentDiscount ?? this.studentDiscount,
      groupDiscount: groupDiscount ?? this.groupDiscount,
      issueCertificates: issueCertificates ?? this.issueCertificates,
      certificateType: certificateType ?? this.certificateType,
      templateId: templateId ?? this.templateId,
      minAttendance: minAttendance ?? this.minAttendance,
      mustCompleteSurvey: mustCompleteSurvey ?? this.mustCompleteSurvey,
      views: views ?? this.views,
      registrations: registrations ?? this.registrations,
      checkIns: checkIns ?? this.checkIns,
      completionRate: completionRate ?? this.completionRate,
      revenue: revenue ?? this.revenue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }
}
