// lib/viewmodels/vendor_reviews_viewmodel.dart

import 'package:flutter_riverpod/legacy.dart';
import '../models/review_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════

class VendorReviewsState {
  final List<ReviewModel> reviews;
  final String selectedSortOption;
  final bool isLoading;

  const VendorReviewsState({
    this.reviews = const [],
    this.selectedSortOption = 'Most popular',
    this.isLoading = false,
  });

  VendorReviewsState copyWith({
    List<ReviewModel>? reviews,
    String? selectedSortOption,
    bool? isLoading,
  }) {
    return VendorReviewsState(
      reviews: reviews ?? this.reviews,
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // ── Computed Properties ────────────────────────────────
  
  int get totalReviews => reviews.length;
  
  double get averageRating {
    if (reviews.isEmpty) return 0.0;
    double sum = 0;
    for (var r in reviews) {
      sum += r.overallRating;
    }
    return sum / reviews.length;
  }
  
  double getRatingPercentage(int stars) {
    if (reviews.isEmpty) return 0.0;
    int count = reviews.where((r) => r.overallRating.round() == stars).length;
    return count / reviews.length;
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// ═════════════════════════════════════════════════════

class VendorReviewsViewModel extends StateNotifier<VendorReviewsState> {
  VendorReviewsViewModel() : super(const VendorReviewsState(isLoading: true)) {
    loadReviews();
  }

  Future<void> loadReviews() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network

    // Dummy reviews mimicking the UI on Screen 38
    final dummyReviews = [
      ReviewModel(
        reviewId: 'R1',
        targetId: 'V1',
        authorId: 'U1',
        authorName: 'Sophia Bennett',
        authorInitials: 'SB',
        avatarColorValue: 0xFFDCC8B3,
        overallRating: 5.0,
        reviewText: 'The vendor was professional and delivered the setup perfectly on time. Highly recommend! ...Read more',
        eventContext: 'Corporate Gala',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ReviewModel(
        reviewId: 'R2',
        targetId: 'V1',
        authorId: 'U2',
        authorName: 'Ethan Carter',
        authorInitials: 'EC',
        avatarColorValue: 0xFFC4D5D9,
        overallRating: 4.0,
        reviewText: 'Good service, but there were some minor delays. Overall, satisfied. ...Read more',
        eventContext: 'University Workshop',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      ReviewModel(
        reviewId: 'R3',
        targetId: 'V1',
        authorId: 'U3',
        authorName: 'Olivia Davis',
        authorInitials: 'OD',
        avatarColorValue: 0xFFD9A683,
        overallRating: 5.0,
        reviewText: 'Absolutely fantastic! The team went above and beyond to make our day special. ...Read more',
        eventContext: 'Wedding Reception',
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
      ),
      ReviewModel(
        reviewId: 'R4',
        targetId: 'V1',
        authorId: 'U4',
        authorName: 'Liam Foster',
        authorInitials: 'LF',
        avatarColorValue: 0xFF1E3636,
        overallRating: 3.0,
        reviewText: 'Decent, but communication could have been better. Some issues with the setup. ...Read more',
        eventContext: 'Birthday Party',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      ReviewModel(
        reviewId: 'R5',
        targetId: 'V1',
        authorId: 'U5',
        authorName: 'Ava Green',
        authorInitials: 'AG',
        avatarColorValue: 0xFFDCC8B3,
        overallRating: 5.0,
        reviewText: 'Exceptional service! The vendor was punctual, organized, and the quality was top-notch. ...Read more',
        eventContext: 'Conference',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
    ];

    state = state.copyWith(
      reviews: dummyReviews,
      isLoading: false,
    );
  }

  void setSortOption(String option) {
    state = state.copyWith(selectedSortOption: option);
    // Add sorting logic if needed
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// ═════════════════════════════════════════════════════

final vendorReviewsProvider = StateNotifierProvider<VendorReviewsViewModel, VendorReviewsState>((ref) {
  return VendorReviewsViewModel();
});
