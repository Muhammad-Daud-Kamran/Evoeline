// lib/models/user_model.dart

// ─────────────────────────────────────────────────────
// Schema: users/:userId
//
// Complete mapping according to EventFlow schema.
// Includes security, verification timestamps, and all timestamps as DateTime.
// ─────────────────────────────────────────────────────

class UserModel {
  // ── Core Identity ──────────────────────────────────
  final String userId; // U001, U002
  final String email; // used for Firebase Auth
  final String userType; // attendee | organizer | vendor | admin
  final String accountStatus; // active | suspended | deactivated

  // ── Profile ────────────────────────────────────────
  final String fullName;
  final String phoneNumber;
  final String profileImageUrl;
  final String gender; // male | female | other

  // ── Location ───────────────────────────────────────
  final String city;
  final String country;

  // ── Preferences ────────────────────────────────────
  final bool emailNotifications;
  final bool pushNotifications;
  final String language; // en | ur
  final String theme; // light | dark

  // ── Security ───────────────────────────────────────
  final DateTime? lastLogin;
  final int loginCount;
  final int failedLoginAttempts;
  final bool mfaEnabled;
  final String? mfaMethod; // sms, authenticator

  // ── Verification ───────────────────────────────────
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;

  // ── Timestamps ─────────────────────────────────────
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastActive;

  const UserModel({
    required this.userId,
    required this.email,
    required this.userType,
    this.accountStatus = 'active',
    required this.fullName,
    this.phoneNumber = '',
    this.profileImageUrl = '',
    this.gender = '',
    this.city = '',
    this.country = 'Pakistan',
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.language = 'en',
    this.theme = 'light',
    this.lastLogin,
    this.loginCount = 0,
    this.failedLoginAttempts = 0,
    this.mfaEnabled = false,
    this.mfaMethod,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.lastActive,
  });

  // ── empty() ───────────────────────────────────────
  factory UserModel.empty() {
    return UserModel(
      userId: '',
      email: '',
      userType: '',
      fullName: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastActive: DateTime.now(),
    );
  }

  // ── dummy() ───────────────────────────────────────
  factory UserModel.dummy() {
    return UserModel(
      userId: 'U001',
      email: 'dummy@example.com',
      userType: 'attendee',
      fullName: 'John Doe',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastActive: DateTime.now(),
    );
  }

  // ── copyWith() ────────────────────────────────────
  UserModel copyWith({
    String? userId,
    String? email,
    String? userType,
    String? accountStatus,
    String? fullName,
    String? phoneNumber,
    String? profileImageUrl,
    String? gender,
    String? city,
    String? country,
    bool? emailNotifications,
    bool? pushNotifications,
    String? language,
    String? theme,
    DateTime? lastLogin,
    int? loginCount,
    int? failedLoginAttempts,
    bool? mfaEnabled,
    String? mfaMethod,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    DateTime? emailVerifiedAt,
    DateTime? phoneVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActive,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      accountStatus: accountStatus ?? this.accountStatus,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      country: country ?? this.country,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      lastLogin: lastLogin ?? this.lastLogin,
      loginCount: loginCount ?? this.loginCount,
      failedLoginAttempts: failedLoginAttempts ?? this.failedLoginAttempts,
      mfaEnabled: mfaEnabled ?? this.mfaEnabled,
      mfaMethod: mfaMethod ?? this.mfaMethod,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}
