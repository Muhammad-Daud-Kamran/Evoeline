// lib/models/registration_model.dart

// ─────────────────────────────────────────────────────
// Schema: registrations/:registrationId
//
// Used in Screen 27 for:
//   status              → statusText badge
//   checkIn.checkedIn   → green dot + Checked In filter
//   payment.amountPaid  → PKR 1500
//   payment.paymentStatus → Paid/Unpaid badge
//   payment.currency    → PKR
//
// Also links to:
//   eventId → which event this registration belongs to
//   userId  → which user registered (links to UserModel)
// ─────────────────────────────────────────────────────

class RegistrationModel {

  // ── Core Identity ──────────────────────────────────
  // Schema: registrations.registrationId etc

  final String registrationId; // REG001, REG002
  final String eventId;        // ref to events/
  final String userId;         // ref to users/
  final String organizerId;    // ref to users/
  final String registrationDate;
  // mobile_app | web | admin_panel
  final String registrationSource;

  // ── Status ─────────────────────────────────────────
  // Schema: registrations.status
  // pending | confirmed | checked_in | attended | cancelled | no_show
  final String status;

  // ── Payment ────────────────────────────────────────
  // Schema: registrations.payment.*
  // Used in Screen 27 payment badge

  final String paymentId;      // ref to payments/
  final double amountPaid;     // 1500
  final String currency;       // PKR
  // jazzcash | easypaisa | stripe
  final String paymentMethod;
  // completed | pending | failed
  final String paymentStatus;
  final String transactionId;

  // ── Pricing ────────────────────────────────────────
  // Schema: registrations.pricingTier, finalPrice
  final String pricingTier;    // Early Bird | Regular
  final double finalPrice;

  // ── Check-In ───────────────────────────────────────
  // Schema: registrations.checkIn.*
  // Used in Screen 27 green dot + Checked In filter

  final bool   checkedIn;       // true/false
  final String checkInTime;
  // qr_scan | manual | nfc
  final String checkInMethod;
  final String checkedInBy;     // organizer userId

  // ── QR Code ────────────────────────────────────────
  // Schema: registrations.qrCode.*

  final String qrCodeData;      // "EVT001_U001_REG001"
  final String qrCodeImageUrl;

  // ── Certificate ────────────────────────────────────
  // Schema: registrations.certificate.*

  final bool   certificateIssued;
  final String certificateId;
  final String certificateDownloadUrl;

  // ── Feedback ───────────────────────────────────────
  // Schema: registrations.feedbackSubmitted, rating
  final bool   feedbackSubmitted;
  final double rating;

  // ── Timestamps ─────────────────────────────────────
  final String createdAt;
  final String updatedAt;
  final String cancelledAt;

  const RegistrationModel({
    required this.registrationId,
    required this.eventId,
    required this.userId,
    required this.organizerId,
    this.registrationDate   = '',
    this.registrationSource = 'mobile_app',
    required this.status,
    this.paymentId          = '',
    this.amountPaid         = 0.0,
    this.currency           = 'PKR',
    this.paymentMethod      = '',
    this.paymentStatus      = 'pending',
    this.transactionId      = '',
    this.pricingTier        = '',
    this.finalPrice         = 0.0,
    this.checkedIn          = false,
    this.checkInTime        = '',
    this.checkInMethod      = '',
    this.checkedInBy        = '',
    this.qrCodeData         = '',
    this.qrCodeImageUrl     = '',
    this.certificateIssued  = false,
    this.certificateId      = '',
    this.certificateDownloadUrl = '',
    this.feedbackSubmitted  = false,
    this.rating             = 0.0,
    this.createdAt          = '',
    this.updatedAt          = '',
    this.cancelledAt        = '',
  });

  // ── Helpers ────────────────────────────────────────

  // Is payment done?
  bool get isPaid => paymentStatus == 'completed';

  // Is this a no show?
  bool get isNoShow => status == 'no_show';

  // Is registration confirmed or above?
  bool get isConfirmed =>
      status == 'confirmed' ||
          status == 'checked_in' ||
          status == 'attended';
}

