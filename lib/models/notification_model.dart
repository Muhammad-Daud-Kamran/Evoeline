class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.type,
  });

  // Dummy Data for sample UI
  static List<NotificationModel> getDummyNotifications() {
    return [
      NotificationModel(
        id: 'n_1',
        title: 'Event Reminder',
        message: 'Your Web3 Seminar starts in 2 hours. Don\'t miss it!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: false,
        type: 'reminder',
      ),
      NotificationModel(
        id: 'n_2',
        title: 'Certificate Issued',
        message:
            'You have earned a certificate for attending Flutter BootCamp.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
        type: 'certificate',
      ),
    ];
  }
}
