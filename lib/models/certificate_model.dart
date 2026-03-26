// lib/models/certificate_model.dart

// ─────────────────────────────────────────────────────
// Schema: certificates/:certificateId
//
// Manages certificate issuance and verification.
// ─────────────────────────────────────────────────────

class CertificateModel {
  final String certificateId; // CERT001, CERT002...
  final String registrationId; // Reference to registration
  final String userId; // Certificate recipient
  final String eventId; // Reference to event
  final String organizerId; // Issuer

  // Certificate Details
  final String type; // "digital" | "blockchain" | "both"
  final String title;
  final String description;

  // Content
  final Map<String, dynamic> content;
  /*
  {
    "recipientName": "Ali Ahmed Khan",
    "eventTitle": "Advanced Flutter & Firebase Workshop",
    "completionDate": "2024-04-16",
    "grade": "A+",
    "duration": "14 hours",
    "issuerName": "NED University Department of CS",
    "issuerSignature": "https://storage/signatures/sig1.png",
    "uniqueId": "CERT-2024-001-001"
  }
  */

  // Digital Certificate
  final Map<String, dynamic> digital;
  /*
  {
    "pdfUrl": "https://storage/certificates/CERT001.pdf",
    "templateId": "TEMPLATE_01",
    "design": { ... },
    "downloadCount": 3,
    "lastDownloaded": timestamp
  }
  */

  // Blockchain Certificate
  final Map<String, dynamic> blockchain;
  /*
  {
    "minted": true,
    "network": "Polygon",
    "tokenId": "123456",
    "tokenStandard": "ERC-721",
    "contractAddress": "0x...",
    "transactionHash": "0x...",
    "blockNumber": 41234567,
    "gasUsed": "0.0021 MATIC",
    "metadata": { ... },
    "verificationUrl": "https://..."
  }
  */

  // Validation
  final Map<String, dynamic> validation;
  /*
  {
    "verificationCode": "EVT2024-001-ABC123",
    "verificationUrl": "https://eventflow.com/verify/CERT001",
    "isVerified": true,
    "verifiedBy": "U003",
    "verifiedAt": timestamp,
    "verificationCount": 5
  }
  */

  // Sharing & Social
  final Map<String, dynamic> socialSharing;
  /*
  {
    "sharedOnLinkedIn": true,
    "linkedInPostId": "urn:li:share:123456",
    "sharedOnTwitter": false,
    "sharedOnFacebook": false,
    "shareCount": 1
  }
  */

  // Status
  final String status; // "generating" | "ready" | "issued" | "revoked"
  final String? revokeReason;
  final DateTime? revokedAt;

  // Timestamps
  final DateTime createdAt;
  final DateTime issuedAt;
  final DateTime expiresAt;
  final DateTime updatedAt;

  const CertificateModel({
    required this.certificateId,
    required this.registrationId,
    required this.userId,
    required this.eventId,
    required this.organizerId,
    required this.type,
    required this.title,
    required this.description,
    required this.content,
    required this.digital,
    required this.blockchain,
    required this.validation,
    required this.socialSharing,
    required this.status,
    this.revokeReason,
    this.revokedAt,
    required this.createdAt,
    required this.issuedAt,
    required this.expiresAt,
    required this.updatedAt,
  });

  // Empty factory for initial states
  factory CertificateModel.empty() {
    return CertificateModel(
      certificateId: '',
      registrationId: '',
      userId: '',
      eventId: '',
      organizerId: '',
      type: 'digital',
      title: 'Certificate of Completion',
      description: '',
      content: const {},
      digital: const {},
      blockchain: const {},
      validation: const {},
      socialSharing: const {},
      status: 'generating',
      createdAt: DateTime.now(),
      issuedAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(days: 365 * 5)),
      updatedAt: DateTime.now(),
    );
  }

  static List<CertificateModel> getDummyCertificates() {
    return [
      CertificateModel.empty().copyWith(
        certificateId: 'CERT-001',
        eventId: 'EVT-001',
        title: 'Advanced Flutter Workshop',
        description: 'Successfully completed the advanced Flutter workshop.',
        status: 'issued',
      ),
      CertificateModel.empty().copyWith(
        certificateId: 'CERT-002',
        eventId: 'EVT-002',
        title: 'Firebase Masterclass',
        description: 'Completed the comprehensive Firebase architecture class.',
        status: 'issued',
      ),
    ];
  }

  CertificateModel copyWith({
    String? certificateId,
    String? registrationId,
    String? userId,
    String? eventId,
    String? organizerId,
    String? type,
    String? title,
    String? description,
    Map<String, dynamic>? content,
    Map<String, dynamic>? digital,
    Map<String, dynamic>? blockchain,
    Map<String, dynamic>? validation,
    Map<String, dynamic>? socialSharing,
    String? status,
    String? revokeReason,
    DateTime? revokedAt,
    DateTime? createdAt,
    DateTime? issuedAt,
    DateTime? expiresAt,
    DateTime? updatedAt,
  }) {
    return CertificateModel(
      certificateId: certificateId ?? this.certificateId,
      registrationId: registrationId ?? this.registrationId,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      organizerId: organizerId ?? this.organizerId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      digital: digital ?? this.digital,
      blockchain: blockchain ?? this.blockchain,
      validation: validation ?? this.validation,
      socialSharing: socialSharing ?? this.socialSharing,
      status: status ?? this.status,
      revokeReason: revokeReason ?? this.revokeReason,
      revokedAt: revokedAt ?? this.revokedAt,
      createdAt: createdAt ?? this.createdAt,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
