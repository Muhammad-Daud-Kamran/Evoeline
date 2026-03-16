class AnalyticsModel {
  final String eventId;
  final int totalViews;
  final int totalRegistrations;
  final double revenue;
  final double attendanceRate;

  AnalyticsModel({
    required this.eventId,
    required this.totalViews,
    required this.totalRegistrations,
    required this.revenue,
    required this.attendanceRate,
  });

  // Dummy Data for sample analytics
  factory AnalyticsModel.dummy() {
    return AnalyticsModel(
      eventId: 'evt_1',
      totalViews: 12500,
      totalRegistrations: 420,
      revenue: 15400.0,
      attendanceRate: 85.5,
    );
  }
}
