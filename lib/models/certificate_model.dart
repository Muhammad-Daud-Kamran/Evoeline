class CertificateModel {
  final String id;
  final String eventId;
  final String eventName;
  final DateTime issueDate;
  final String downloadUrl;

  CertificateModel({
    required this.id,
    required this.eventId,
    required this.eventName,
    required this.issueDate,
    required this.downloadUrl,
  });

  // Dummy Data for sample UI
  static List<CertificateModel> getDummyCertificates() {
    return [
      CertificateModel(
        id: 'cert_101',
        eventId: 'evt_1',
        eventName: 'Flutter Forward Extended',
        issueDate: DateTime.now().subtract(const Duration(days: 10)),
        downloadUrl: 'https://example.com/certificates/cert_101.pdf',
      ),
      CertificateModel(
        id: 'cert_102',
        eventId: 'evt_2',
        eventName: 'UI/UX Masterclass 2024',
        issueDate: DateTime.now().subtract(const Duration(days: 45)),
        downloadUrl: 'https://example.com/certificates/cert_102.pdf',
      ),
    ];
  }
}
