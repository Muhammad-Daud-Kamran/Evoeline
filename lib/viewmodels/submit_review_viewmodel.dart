// lib/viewmodels/submit_review_viewmodel.dart

import 'package:flutter_riverpod/legacy.dart';

class SubmitReviewState {
  final int overallRating;
  final int qualityRating;
  final int professionalismRating;
  final int valueRating;
  final int communicationRating;
  final int timelinessRating;
  final bool recommendVendor;
  final String reviewText;
  final List<String> selectedProsCons;
  final bool isSubmitting;
  final bool submissionSuccess;

  const SubmitReviewState({
    this.overallRating = 5,
    this.qualityRating = 5,
    this.professionalismRating = 5,
    this.valueRating = 5,
    this.communicationRating = 5,
    this.timelinessRating = 5,
    this.recommendVendor = true,
    this.reviewText = '',
    this.selectedProsCons = const [],
    this.isSubmitting = false,
    this.submissionSuccess = false,
  });

  SubmitReviewState copyWith({
    int? overallRating,
    int? qualityRating,
    int? professionalismRating,
    int? valueRating,
    int? communicationRating,
    int? timelinessRating,
    bool? recommendVendor,
    String? reviewText,
    List<String>? selectedProsCons,
    bool? isSubmitting,
    bool? submissionSuccess,
  }) {
    return SubmitReviewState(
      overallRating: overallRating ?? this.overallRating,
      qualityRating: qualityRating ?? this.qualityRating,
      professionalismRating: professionalismRating ?? this.professionalismRating,
      valueRating: valueRating ?? this.valueRating,
      communicationRating: communicationRating ?? this.communicationRating,
      timelinessRating: timelinessRating ?? this.timelinessRating,
      recommendVendor: recommendVendor ?? this.recommendVendor,
      reviewText: reviewText ?? this.reviewText,
      selectedProsCons: selectedProsCons ?? this.selectedProsCons,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
    );
  }
}

class SubmitReviewViewModel extends StateNotifier<SubmitReviewState> {
  SubmitReviewViewModel() : super(const SubmitReviewState()) {
    // Initial UI state setup mimic
    state = state.copyWith(selectedProsCons: [
      'High Quality',
      'On-time Delivery',
      'Smooth Setup',
    ]);
  }

  void setOverallRating(int rating) {
    state = state.copyWith(overallRating: rating);
  }

  void setDetailedRating(String category, int rating) {
    switch (category) {
      case 'quality':
        state = state.copyWith(qualityRating: rating);
        break;
      case 'professionalism':
        state = state.copyWith(professionalismRating: rating);
        break;
      case 'value':
        state = state.copyWith(valueRating: rating);
        break;
      case 'communication':
        state = state.copyWith(communicationRating: rating);
        break;
      case 'timeliness':
        state = state.copyWith(timelinessRating: rating);
        break;
    }
  }

  void setReviewText(String text) {
    state = state.copyWith(reviewText: text);
  }

  void toggleProCon(String option) {
    final currentList = List<String>.from(state.selectedProsCons);
    if (currentList.contains(option)) {
      currentList.remove(option);
    } else {
      currentList.add(option);
    }
    state = state.copyWith(selectedProsCons: currentList);
  }

  void setRecommendVendor(bool recommend) {
    state = state.copyWith(recommendVendor: recommend);
  }

  Future<void> submitReview() async {
    state = state.copyWith(isSubmitting: true);
    // Simulate network write operation
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false, submissionSuccess: true);
  }
}

final submitReviewProvider = StateNotifierProvider<SubmitReviewViewModel, SubmitReviewState>((ref) {
  return SubmitReviewViewModel();
});
