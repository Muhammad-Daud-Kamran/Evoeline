// lib/viewmodels/photography_category_viewmodel.dart

// ─────────────────────────────────────────────────────
// ViewModel for Screen 36 — Photography Category
//
// Manages the state for photography vendors, including:
// - List of all photography vendors (using VendorModel)
// - Currently selected filter (All, Wedding, Corporate, Fashion)
// - Loading state
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/legacy.dart';
import '../models/vendor_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════

class PhotographyCategoryState {
  final List<VendorModel> allPhotographers;
  final String selectedFilter; // 'All', 'Wedding', 'Corporate', 'Fashion'
  final bool isLoading;
  final String errorMessage;

  const PhotographyCategoryState({
    this.allPhotographers = const [],
    this.selectedFilter = 'All',
    this.isLoading = false,
    this.errorMessage = '',
  });

  List<VendorModel> get filteredPhotographers {
    if (selectedFilter == 'All') {
      return allPhotographers;
    }
    return allPhotographers.where((vendor) {
      return vendor.serviceCategories.contains(selectedFilter);
    }).toList();
  }

  PhotographyCategoryState copyWith({
    List<VendorModel>? allPhotographers,
    String? selectedFilter,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PhotographyCategoryState(
      allPhotographers: allPhotographers ?? this.allPhotographers,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// ═════════════════════════════════════════════════════

class PhotographyCategoryViewModel extends StateNotifier<PhotographyCategoryState> {
  PhotographyCategoryViewModel() : super(const PhotographyCategoryState()) {
    loadPhotographers();
  }

  // ── Load Dummy Photography Vendors ─────────────────
  Future<void> loadPhotographers() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final mockPhotographers = [
        VendorModel(
          vendorId: 'V101',
          userId: 'U101',
          businessName: 'Capture Moments Photography',
          serviceCategories: ['Wedding', 'Corporate', 'Fashion'],
          averageRating: 4.9,
          totalReviews: 120,
          isVerified: true,
          isFeatured: true,
          verificationBadges: ['Top Rated'], // Custom mapping to badge
          logoImage: 'assets/images/s36image2.jpg',
        ),
        VendorModel(
          vendorId: 'V102',
          userId: 'U102',
          businessName: 'EventSnap Studios',
          serviceCategories: ['Corporate', 'Fashion'],
          averageRating: 4.7,
          totalReviews: 85,
          isVerified: true,
          verificationBadges: ['Popular'],
          logoImage: 'assets/images/s36image3.jpg',
        ),
        VendorModel(
          vendorId: 'V103',
          userId: 'U103',
          businessName: 'PixelPerfect Photography',
          serviceCategories: ['Wedding', 'Fashion'],
          averageRating: 4.8,
          totalReviews: 200,
          isVerified: true,
          logoImage: 'assets/images/s36image4.jpg',
        ),
        VendorModel(
          vendorId: 'V104',
          userId: 'U104',
          businessName: 'FrameMasters Photography',
          serviceCategories: ['Corporate'],
          averageRating: 4.6,
          totalReviews: 65,
          isVerified: true,
          logoImage: 'assets/images/s36image5.jpg',
        ),
        VendorModel(
          vendorId: 'V105',
          userId: 'U105',
          businessName: 'VisualVibes Photography',
          serviceCategories: ['Wedding', 'Corporate', 'Fashion'],
          averageRating: 4.5,
          totalReviews: 45,
          isVerified: false,
          logoImage: 'assets/images/s36image6.jpg',
        ),
      ];

      state = state.copyWith(
        allPhotographers: mockPhotographers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load photographers',
      );
    }
  }

  // ── Selections ─────────────────────────────────────

  void selectFilter(String filterName) {
    state = state.copyWith(selectedFilter: filterName);
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// ═════════════════════════════════════════════════════

final photographyCategoryProvider = StateNotifierProvider<PhotographyCategoryViewModel, PhotographyCategoryState>((ref) {
  return PhotographyCategoryViewModel();
});
