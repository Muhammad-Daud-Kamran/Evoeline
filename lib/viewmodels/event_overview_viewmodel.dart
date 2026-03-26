// lib/viewmodels/analytics_viewmodel.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/analytics_model.dart';

// ═════════════════════════════════════════════════════
// PART A — STATE CLASS
// ═════════════════════════════════════════════════════

class AnalyticsState {
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

  Future<void> loadAnalytics() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // Simulation of network delay
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

  AnalyticsModel _getDummyAnalytics() {
    return const AnalyticsModel(
      totalRegistrations: 2450,
      newToday: 89,
      confirmedCount: 2300,
      pendingCount: 100,
      cancelledCount: 50,
      conversionRate: 3.6,
      certificatesIssued: 1800,
      digitalCertificates: 1700,
      blockchainCertificates: 100,
      verificationRate: 25.5,
      totalRevenue: 450000,
      todayRevenue: 150000,
      platformCosts: 15000,
      gatewayFees: 7500,
      netRevenue: 427500,
      avgTransactionValue: 1875,
      totalUsers: 1250,
      activeUsers: 850,
      newUsers: 45,
      activeVendors: 45,
      totalBookings: 120,
      avgVendorRating: 4.3,
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

// Fixed: Corrected StateNotifierProvider syntax
final analyticsProvider = StateNotifierProvider<AnalyticsViewModel, AnalyticsState>((ref) {
  return AnalyticsViewModel();
});