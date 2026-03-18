class EventModel {
  final String eventId;
  final String organizerId;
  final String title;
  final String description;
  final String shortDescription;
  final String category;
  final String eventType;
  final String format;
  final String status;
  final String visibility;

  final String bannerImage;
  final List<String> galleryImages;

  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String timezone;

  final String venueName;
  final String address;
  final String city;
  final String country;
  final double latitude;
  final double longitude;

  final int totalSeats;
  final int reservedSeats;
  final int availableSeats;

  final String registrationOpenDate;
  final String registrationCloseDate;
  final bool requiresApproval;

  final List<dynamic> customFields;

  final bool isFree;
  final String currency;

  final List<dynamic> tiers;

  final dynamic studentDiscount;
  final dynamic groupDiscount;

  final bool issueCertificates;
  final String certificateType;
  final int minAttendance;
  final bool mustCompleteSurvey;

  final int views;
  final int registrations;
  final int checkIns;
  final double completionRate;
  final int revenue;

  final String createdAt;
  final String updatedAt;
  final String publishedAt;

  const EventModel({
    required this.eventId,
    required this.organizerId,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.category,
    required this.eventType,
    required this.format,
    required this.status,
    required this.visibility,
    required this.bannerImage,
    required this.galleryImages,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.timezone,
    required this.venueName,
    required this.address,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.totalSeats,
    required this.reservedSeats,
    required this.availableSeats,
    required this.registrationOpenDate,
    required this.registrationCloseDate,
    required this.requiresApproval,
    required this.customFields,
    required this.isFree,
    required this.currency,
    required this.tiers,
    required this.studentDiscount,
    required this.groupDiscount,
    required this.issueCertificates,
    required this.certificateType,
    required this.minAttendance,
    required this.mustCompleteSurvey,
    required this.views,
    required this.registrations,
    required this.checkIns,
    required this.completionRate,
    required this.revenue,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  // ✅ EMPTY CONSTRUCTOR (Fixes your error)
  factory EventModel.empty() {
    return const EventModel(
      eventId: '',
      organizerId: '',
      title: '',
      description: '',
      shortDescription: '',
      category: '',
      eventType: '',
      format: '',
      status: '',
      visibility: '',
      bannerImage: '',
      galleryImages: [],
      startDate: '',
      endDate: '',
      startTime: '',
      endTime: '',
      timezone: '',
      venueName: '',
      address: '',
      city: '',
      country: '',
      latitude: 0.0,
      longitude: 0.0,
      totalSeats: 0,
      reservedSeats: 0,
      availableSeats: 0,
      registrationOpenDate: '',
      registrationCloseDate: '',
      requiresApproval: false,
      customFields: [],
      isFree: true,
      currency: '',
      tiers: [],
      studentDiscount: null,
      groupDiscount: null,
      issueCertificates: false,
      certificateType: '',
      minAttendance: 0,
      mustCompleteSurvey: false,
      views: 0,
      registrations: 0,
      checkIns: 0,
      completionRate: 0.0,
      revenue: 0,
      createdAt: '',
      updatedAt: '',
      publishedAt: '',
    );
  }
}