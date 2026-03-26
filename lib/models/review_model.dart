// lib/models/review_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// Data model for Feedback & Reviews.
// Matches schema requirements for Vendor Reviews.
// ─────────────────────────────────────────────────────

class ReviewModel {
  final String reviewId;
  final String targetId; // ID of the entity being reviewed (e.g., vendorId)
  final String authorId;
  final String authorName;
  final String authorInitials;
  final int avatarColorValue; // Storing as integer representation of color
  
  // Ratings
  final double overallRating; // e.g. 4.8
  final Map<String, int> detailedRatings; // {'Quality': 5, 'Timeliness': 4, ...}
  
  // Content
  final String reviewText;
  final List<String> prosCons;
  final bool wouldRecommend;
  final List<String> photoUrls;
  
  // Context
  final String eventContext; // e.g., "Corporate Gala"
  final DateTime createdAt;

  const ReviewModel({
    required this.reviewId,
    required this.targetId,
    required this.authorId,
    required this.authorName,
    this.authorInitials = '',
    this.avatarColorValue = 0xFFDCC8B3, // Default color from UI
    required this.overallRating,
    this.detailedRatings = const {},
    required this.reviewText,
    this.prosCons = const [],
    this.wouldRecommend = true,
    this.photoUrls = const [],
    this.eventContext = '',
    required this.createdAt,
  });

  factory ReviewModel.empty() {
    return ReviewModel(
      reviewId: '',
      targetId: '',
      authorId: '',
      authorName: '',
      overallRating: 0.0,
      reviewText: '',
      createdAt: DateTime.now(),
    );
  }

  ReviewModel copyWith({
    String? reviewId,
    String? targetId,
    String? authorId,
    String? authorName,
    String? authorInitials,
    int? avatarColorValue,
    double? overallRating,
    Map<String, int>? detailedRatings,
    String? reviewText,
    List<String>? prosCons,
    bool? wouldRecommend,
    List<String>? photoUrls,
    String? eventContext,
    DateTime? createdAt,
  }) {
    return ReviewModel(
      reviewId: reviewId ?? this.reviewId,
      targetId: targetId ?? this.targetId,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorInitials: authorInitials ?? this.authorInitials,
      avatarColorValue: avatarColorValue ?? this.avatarColorValue,
      overallRating: overallRating ?? this.overallRating,
      detailedRatings: detailedRatings ?? this.detailedRatings,
      reviewText: reviewText ?? this.reviewText,
      prosCons: prosCons ?? this.prosCons,
      wouldRecommend: wouldRecommend ?? this.wouldRecommend,
      photoUrls: photoUrls ?? this.photoUrls,
      eventContext: eventContext ?? this.eventContext,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
