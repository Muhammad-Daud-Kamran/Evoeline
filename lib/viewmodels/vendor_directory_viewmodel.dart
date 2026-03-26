// lib/viewmodels/vendor_directory_viewmodel.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// ViewModel for Screen 35 — Vendor Directory.
//
// CONTAINS:
//   VendorDirectoryState   → snapshot of UI state
//   VendorDirectoryViewModel → logic to load vendors
//   vendorDirectoryProvider → Riverpod provider
//
// DATA: dummy data embedded (replace with repository later)
// ─────────────────────────────────────────────────────
import 'package:flutter_riverpod/legacy.dart';
import '../models/vendor_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════
class VendorDirectoryState {
  final List<VendorModel> featuredVendors;
  final List<VendorModel> popularVendors;
  final List<VendorModel> recentlyViewed;
  final List<String> categories;         // static or dynamic
  final bool isLoading;
  final String errorMessage;

  const VendorDirectoryState({
    this.featuredVendors = const [],
    this.popularVendors = const [],
    this.recentlyViewed = const [],
    this.categories = const [
      'Venues', 'Catering', 'Photography', 'Decoration',
      'AV Equipment', 'Entertainment', 'Security', 'Transportation'
    ],
    this.isLoading = true,
    this.errorMessage = '',
  });

  VendorDirectoryState copyWith({
    List<VendorModel>? featuredVendors,
    List<VendorModel>? popularVendors,
    List<VendorModel>? recentlyViewed,
    List<String>? categories,
    bool? isLoading,
    String? errorMessage,
  }) {
    return VendorDirectoryState(
      featuredVendors: featuredVendors ?? this.featuredVendors,
      popularVendors: popularVendors ?? this.popularVendors,
      recentlyViewed: recentlyViewed ?? this.recentlyViewed,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// ═════════════════════════════════════════════════════
class VendorDirectoryViewModel extends StateNotifier<VendorDirectoryState> {
  VendorDirectoryViewModel() : super(VendorDirectoryState()) {
    loadData();
  }

  // ── Load all vendor data (dummy) ────────────────────
  Future<void> loadData() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      await Future.delayed(const Duration(milliseconds: 600)); // simulate network

      final featured = _getFeaturedVendors();
      final popular = _getPopularVendors();
      final recently = _getRecentlyViewed();

      state = state.copyWith(
        featuredVendors: featured,
        popularVendors: popular,
        recentlyViewed: recently,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load vendors. Please try again.',
      );
    }
  }

  // ── Dummy Data Methods ──────────────────────────────
  List<VendorModel> _getFeaturedVendors() {
    return [
      VendorModel(
        vendorId: 'V001',
        userId: 'U011',
        businessName: 'The Grand Ballroom',
        serviceCategories: ['Venues'],
        averageRating: 4.8,
        totalReviews: 230,
        totalBookings: 45,
        isVerified: true,
        isFeatured: true,
        logoImage: 'assets/images/s35imag1.jpg',
      ),
      VendorModel(
        vendorId: 'V002',
        userId: 'U012',
        businessName: 'Cuisine Masters',
        serviceCategories: ['Catering'],
        averageRating: 4.9,
        totalReviews: 180,
        totalBookings: 60,
        isVerified: true,
        isFeatured: true,
        logoImage: 'assets/images/s35image2.png',
      ),
    ];
  }

  List<VendorModel> _getPopularVendors() {
    return [
      VendorModel(
        vendorId: 'V003',
        userId: 'U013',
        businessName: 'Elite Events Co.',
        serviceCategories: ['Event Planning'],
        averageRating: 4.7,
        totalReviews: 312,
        totalBookings: 89,
        isVerified: true,
        logoImage: 'assets/images/s35image11.jpg',
      ),
      VendorModel(
        vendorId: 'V004',
        userId: 'U014',
        businessName: 'Catering Delights',
        serviceCategories: ['Catering'],
        averageRating: 4.8,
        totalReviews: 156,
        totalBookings: 44,
        isVerified: true,
        logoImage: 'assets/images/s35image12.jpg',
      ),
      VendorModel(
        vendorId: 'V005',
        userId: 'U015',
        businessName: 'PhotoGenius Studios',
        serviceCategories: ['Photography'],
        averageRating: 4.9,
        totalReviews: 420,
        totalBookings: 120,
        isVerified: true,
        logoImage: 'assets/images/s35image13.jpg',
      ),
      VendorModel(
        vendorId: 'V006',
        userId: 'U016',
        businessName: 'Decor Dreams',
        serviceCategories: ['Decoration'],
        averageRating: 4.6,
        totalReviews: 98,
        totalBookings: 32,
        isVerified: true,
        logoImage: 'assets/images/s35image14.jpg',
      ),
    ];
  }

  List<VendorModel> _getRecentlyViewed() {
    // Could be stored per user; using dummy for now
    return [
      VendorModel(
        vendorId: 'V001',
        userId: 'U011',
        businessName: 'The Grand Ballroom',
        serviceCategories: ['Venues'],
        logoImage: 'assets/images/s35image15.jpg',
      ),
      VendorModel(
        vendorId: 'V002',
        userId: 'U012',
        businessName: 'Cuisine Masters',
        serviceCategories: ['Catering'],
        logoImage: 'assets/images/s35image16.jpg',
      ),
    ];
  }

  // ── Actions (optional) ──────────────────────────────
  void searchVendors(String query) {
    // TODO: filter vendors based on query
  }

  void sortBy(String option) {
    // TODO: change sorting
  }

  void filter() {
    // TODO: show filter dialog
  }

  void recordRecentlyViewed(String vendorId) {
    // TODO: update recently viewed list (could be stored locally)
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// ═════════════════════════════════════════════════════
final vendorDirectoryProvider = StateNotifierProvider<VendorDirectoryViewModel, VendorDirectoryState>(
      (ref) => VendorDirectoryViewModel(),
);