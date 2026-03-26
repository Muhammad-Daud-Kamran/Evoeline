// lib/models/analytics_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS FILE?
// Model for the analytics/:date collection in schema
//
// Schema: analytics/:date {
//   registrations { total, newToday, byStatus }
//   certificates  { issued, digital, blockchain }
//   financial     { revenue { total } }
//   users         { total, active }
// }
//
// Screen 26 uses:
//   registrations.total   → Total Registered stat card
//   certificates.issued   → Certificates Issued stat card
//
// RULE: NO logic here — ONLY data fields
// ─────────────────────────────────────────────────────

class AnalyticsModel {

  // ── Registration Metrics ───────────────────────────
  // Schema: analytics.registrations.*

  // Total registrations across ALL events
  final int totalRegistrations;    // 2450

  // New registrations today
  final int newToday;              // 89

  // Registrations by status
  final int confirmedCount;        // 2300
  final int pendingCount;          // 100
  final int cancelledCount;        // 50

  // Percentage of visitors who registered
  final double conversionRate;     // 3.6

  // ── Certificate Metrics ────────────────────────────
  // Schema: analytics.certificates.*

  // Total certificates issued
  final int certificatesIssued;    // 1800

  // Breakdown by type
  final int digitalCertificates;   // 1700
  final int blockchainCertificates;// 100

  // Percentage of certificates that were verified
  final double verificationRate;   // 25.5

  // ── Financial Metrics ──────────────────────────────
  // Schema: analytics.financial.*

  // Total revenue across all events
  final double totalRevenue;       // 450000

  // Revenue earned today
  final double todayRevenue;       // 150000

  // Expenses
  final double platformCosts;      // 15000
  final double gatewayFees;        // 7500

  // Net after expenses
  final double netRevenue;         // 427500

  // Average value per transaction
  final double avgTransactionValue;// 1875

  // ── User Metrics ───────────────────────────────────
  // Schema: analytics.users.*

  final int totalUsers;            // 1250
  final int activeUsers;           // 850
  final int newUsers;              // 45

  // ── Vendor Metrics ─────────────────────────────────
  // Schema: analytics.vendors.*

  final int    activeVendors;      // 45
  final int    totalBookings;      // 120
  final double avgVendorRating;    // 4.3

  // ── Platform Performance ───────────────────────────
  // Schema: analytics.platform.*

  final double uptime;             // 99.9
  final int    avgResponseTime;    // 120ms
  final double errorRate;          // 0.05

  // ── Timestamps ─────────────────────────────────────
  final String date;               // "2024-03-15"
  final String period;             // daily | weekly | monthly

  // ── Constructor ────────────────────────────────────
  const AnalyticsModel({
    this.totalRegistrations     = 0,
    this.newToday               = 0,
    this.confirmedCount         = 0,
    this.pendingCount           = 0,
    this.cancelledCount         = 0,
    this.conversionRate         = 0.0,
    this.certificatesIssued     = 0,
    this.digitalCertificates    = 0,
    this.blockchainCertificates = 0,
    this.verificationRate       = 0.0,
    this.totalRevenue           = 0.0,
    this.todayRevenue           = 0.0,
    this.platformCosts          = 0.0,
    this.gatewayFees            = 0.0,
    this.netRevenue             = 0.0,
    this.avgTransactionValue    = 0.0,
    this.totalUsers             = 0,
    this.activeUsers            = 0,
    this.newUsers               = 0,
    this.activeVendors          = 0,
    this.totalBookings          = 0,
    this.avgVendorRating        = 0.0,
    this.uptime                 = 0.0,
    this.avgResponseTime        = 0,
    this.errorRate              = 0.0,
    this.date                   = '',
    this.period                 = 'daily',
  });

  // ── empty() ────────────────────────────────────────
  // Returns blank analytics — used before data loads
  factory AnalyticsModel.empty() {
    return const AnalyticsModel(date: '', period: 'daily');
  }

  // ── copyWith() ─────────────────────────────────────
  // Updates one field without changing others
  AnalyticsModel copyWith({
    int?    totalRegistrations,
    int?    newToday,
    int?    confirmedCount,
    int?    pendingCount,
    int?    cancelledCount,
    double? conversionRate,
    int?    certificatesIssued,
    int?    digitalCertificates,
    int?    blockchainCertificates,
    double? verificationRate,
    double? totalRevenue,
    double? todayRevenue,
    double? netRevenue,
    double? avgTransactionValue,
    int?    totalUsers,
    int?    activeUsers,
    int?    newUsers,
    int?    activeVendors,
    int?    totalBookings,
    double? avgVendorRating,
    double? uptime,
    int?    avgResponseTime,
    double? errorRate,
    String? date,
    String? period,
  }) {
    return AnalyticsModel(
      totalRegistrations:     totalRegistrations     ?? this.totalRegistrations,
      newToday:               newToday               ?? this.newToday,
      confirmedCount:         confirmedCount         ?? this.confirmedCount,
      pendingCount:           pendingCount           ?? this.pendingCount,
      cancelledCount:         cancelledCount         ?? this.cancelledCount,
      conversionRate:         conversionRate         ?? this.conversionRate,
      certificatesIssued:     certificatesIssued     ?? this.certificatesIssued,
      digitalCertificates:    digitalCertificates    ?? this.digitalCertificates,
      blockchainCertificates: blockchainCertificates ?? this.blockchainCertificates,
      verificationRate:       verificationRate       ?? this.verificationRate,
      totalRevenue:           totalRevenue           ?? this.totalRevenue,
      todayRevenue:           todayRevenue           ?? this.todayRevenue,
      netRevenue:             netRevenue             ?? this.netRevenue,
      avgTransactionValue:    avgTransactionValue    ?? this.avgTransactionValue,
      totalUsers:             totalUsers             ?? this.totalUsers,
      activeUsers:            activeUsers            ?? this.activeUsers,
      newUsers:               newUsers               ?? this.newUsers,
      activeVendors:          activeVendors          ?? this.activeVendors,
      totalBookings:          totalBookings          ?? this.totalBookings,
      avgVendorRating:        avgVendorRating        ?? this.avgVendorRating,
      uptime:                 uptime                 ?? this.uptime,
      avgResponseTime:        avgResponseTime        ?? this.avgResponseTime,
      errorRate:              errorRate              ?? this.errorRate,
      date:                   date                   ?? this.date,
      period:                 period                 ?? this.period,
    );
  }
}