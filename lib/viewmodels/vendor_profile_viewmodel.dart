// lib/viewmodels/vendor_profile_viewmodel.dart

// ─────────────────────────────────────────────────────
// ViewModel for Screen 37 — Vendor Profile
// Manages the state of the active vendor being viewed
// and the state of the active tab.
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/legacy.dart';
import '../models/vendor_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════

class VendorProfileState {
  final VendorModel vendor;
  final int activeTabIndex; // 0: About, 1: Services, 2: Portfolio, 3: Reviews, 4: Availability
  final bool isLoading;

  const VendorProfileState({
    required this.vendor,
    this.activeTabIndex = 0,
    this.isLoading = false,
  });

  VendorProfileState copyWith({
    VendorModel? vendor,
    int? activeTabIndex,
    bool? isLoading,
  }) {
    return VendorProfileState(
      vendor: vendor ?? this.vendor,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// ═════════════════════════════════════════════════════

class VendorProfileViewModel extends StateNotifier<VendorProfileState> {
  VendorProfileViewModel() : super(VendorProfileState(vendor: VendorModel.empty(), isLoading: true)) {
    loadVendorDetails();
  }

  // ── Load Dummy Vendor Detail ────────────────────────
  Future<void> loadVendorDetails() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500));

    // Dummy vendor based on UI content in Screen 37
    final dummyVendor = VendorModel(
      vendorId: 'V001',
      userId: 'U111',
      businessName: 'Cuisine Catering',
      serviceCategories: ['Catering Service'],
      status: 'Active',
      averageRating: 4.8,
      totalReviews: 230,
      totalBookings: 45,
      completedBookings: 42,
      primaryPhone: '+92 300 1234567',
      secondaryPhone: '+92 300 1234568',
      businessEmail: 'info@perfectcatering.pk',
      website: 'https://perfectcatering.pk',
      addressStreet: '123 Commercial Area',
      addressCity: 'Karachi, Pakistan',
      verificationBadges: ['Certified Event Planner', 'Food Safety Certified'],
      logoImage: 'assets/images/s37image2.jpg',
    );

    state = state.copyWith(
      vendor: dummyVendor,
      isLoading: false,
    );
  }

  // ── Tab Management ───────────────────────────────────
  void setTab(int index) {
    state = state.copyWith(activeTabIndex: index);
  }

  // ── Actions ──────────────────────────────────────────
  void toggleFavorite() {
    // Perform specific favorite API action here
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// ═════════════════════════════════════════════════════

final vendorProfileProvider = StateNotifierProvider<VendorProfileViewModel, VendorProfileState>((ref) {
  return VendorProfileViewModel();
});
