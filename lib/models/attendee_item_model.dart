// lib/models/attendee_item_model.dart

// ─────────────────────────────────────────────────────
// WHAT IS THIS?
// A DISPLAY model — combines UserModel + RegistrationModel
// into ONE object that AttendeeListItem widget needs
//
// WHY?
// AttendeeListItem needs:
//   name          → from UserModel.fullName
//   email         → from UserModel.email
//   avatar        → from UserModel.profileImageUrl
//   isCheckedIn   → from RegistrationModel.checkedIn
//   statusText    → from RegistrationModel.status
//   paymentStatus → from RegistrationModel.paymentStatus
//   paymentAmount → from RegistrationModel.amountPaid
//
// Instead of passing both UserModel AND RegistrationModel
// to every widget, we combine them into AttendeeItemModel
//
// This is NOT stored in Firestore
// It is created in the ViewModel by joining User + Registration
// ─────────────────────────────────────────────────────

import 'user_model.dart';
import '../models/registration_models/registration_model.dart';

class AttendeeItemModel {

  // From UserModel
  // Schema: users.profile.fullName
  final String name;

  // From UserModel
  // Schema: users.email
  final String email;

  // From UserModel
  // Schema: users.profile.profileImageUrl
  final String avatarImagePath;

  // From RegistrationModel
  // Schema: registrations.checkIn.checkedIn
  final bool isCheckedIn;

  // From RegistrationModel
  // Schema: registrations.status
  // pending | confirmed | checked_in | attended | no_show
  final String statusText;

  // From RegistrationModel
  // Schema: registrations.payment.paymentStatus
  // completed → shows "Paid" | pending → shows "Unpaid"
  final String paymentStatus;

  // From RegistrationModel
  // Schema: registrations.payment.currency + amountPaid
  // "PKR 1500"
  final String paymentAmount;

  // Keep original IDs for navigation/actions
  final String userId;           // to navigate to user profile
  final String registrationId;   // to perform actions on registration

  const AttendeeItemModel({
    required this.name,
    required this.email,
    required this.avatarImagePath,
    required this.isCheckedIn,
    required this.statusText,
    required this.paymentStatus,
    required this.paymentAmount,
    required this.userId,
    required this.registrationId,
  });

  // ── Factory: Create from UserModel + RegistrationModel ──
  // Called in ViewModel when joining the two collections
  factory AttendeeItemModel.fromModels({
    required UserModel         user,
    required RegistrationModel registration,
  }) {
    return AttendeeItemModel(
      // From UserModel
      name:           user.fullName,
      email:          user.email,
      avatarImagePath: user.profileImageUrl,

      // From RegistrationModel
      isCheckedIn:   registration.checkedIn,
      statusText:    _formatStatus(registration.status),
      paymentStatus: registration.isPaid ? 'Paid' : 'Unpaid',
      paymentAmount: registration.isPaid
          ? '${registration.currency} ${registration.amountPaid.toInt()}'
          : '',

      // IDs
      userId:         user.userId,
      registrationId: registration.registrationId,
    );
  }

  // ── Format status for display ──────────────────────
  // "checked_in" → "Checked In"
  // "no_show"    → "No Show"
  static String _formatStatus(String status) {
    switch (status) {
      case 'checked_in':   return 'Checked In';
      case 'confirmed':    return 'Confirmed';
      case 'pending':      return 'Pending';
      case 'attended':     return 'Attended';
      case 'cancelled':    return 'Cancelled';
      case 'no_show':      return 'No Show';
      default:             return status;
    }
  }
}