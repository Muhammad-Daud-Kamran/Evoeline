// lib/viewmodels/analytics_viewmodel.dart

// ─────────────────────────────────────────────────────
// ViewModel for analytics/:date collection
// Used in Screen 26 for:
//   analytics.totalRegistrations  → Total Registered card
//   analytics.certificatesIssued  → Certificates Issued card
// ─────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/analytics_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════

class AnalyticsState {
  // Full analytics data from analytics/:date
  final AnalyticsModel analytics;
  final bool isLoading;
  final String errorMessage;

  const AnalyticsState({
    required this.analytics,
    this.isLoading = false,
    this.errorMessage = '',
  });

  AnalyticsState copyWith({
    AnalyticsModel? analytics,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AnalyticsState(
      analytics: analytics ?? this.analytics,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ═════════════════════════════════════════════════════
// PART B — VIEWMODEL
// ═════════════════════════════════════════════════════

class AnalyticsViewModel extends StateNotifier<AnalyticsState> {
  AnalyticsViewModel()
      : super(AnalyticsState(
          analytics: AnalyticsModel.empty(),
          isLoading: true,
        )) {
    loadAnalytics();
  }

  // ── Load Analytics ─────────────────────────────────
  // Replace Future.delayed with Firestore later:
  // final doc = await FirebaseFirestore.instance
  //     .collection('analytics')
  //     .doc('2024-03-15')
  //     .get();
  // final analytics = AnalyticsModel.fromMap(doc.data()!);
  Future<void> loadAnalytics() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      state = state.copyWith(
        analytics: _getDummyAnalytics(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load analytics.',
      );
    }
  }

  // ── Dummy Analytics Data ───────────────────────────
  // Schema: analytics/:date
  // Remove when Firebase is connected
  AnalyticsModel _getDummyAnalytics() {
    return const AnalyticsModel(
      // Registration — schema: analytics.registrations.*
      // Screen 26: Total Registered stat card
      totalRegistrations: 2450,
      newToday: 89,
      confirmedCount: 2300,
      pendingCount: 100,
      cancelledCount: 50,
      conversionRate: 3.6,

      // Certificates — schema: analytics.certificates.*
      // Screen 26: Certificates Issued stat card
      certificatesIssued: 1800,
      digitalCertificates: 1700,
      blockchainCertificates: 100,
      verificationRate: 25.5,

      // Financial — schema: analytics.financial.*
      totalRevenue: 450000,
      todayRevenue: 150000,
      platformCosts: 15000,
      gatewayFees: 7500,
      netRevenue: 427500,
      avgTransactionValue: 1875,

      // Users — schema: analytics.users.*
      totalUsers: 1250,
      activeUsers: 850,
      newUsers: 45,

      // Vendors — schema: analytics.vendors.*
      activeVendors: 45,
      totalBookings: 120,
      avgVendorRating: 4.3,

      // Platform — schema: analytics.platform.*
      uptime: 99.9,
      avgResponseTime: 120,
      errorRate: 0.05,

      date: '2024-03-15',
      period: 'daily',
    );
  }
}

// ═════════════════════════════════════════════════════
// PART C — PROVIDER
// ═════════════════════════════════════════════════════

final analyticsProvider = StateNotifierProvider<AnalyticsViewModel, AnalyticsState>((ref) {
  return AnalyticsViewModel();
});
