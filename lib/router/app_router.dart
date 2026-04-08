import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/screen_23_registration.dart';
import '../screens/screen_24_review.dart';
import '../screens/screen_25_event_details.dart';
import '../screens/screen_26_event_overview.dart';
import '../screens/screen_27_attendees.dart';
import '../screens/screen_29_analytics.dart';
import '../screens/screen_30_speaker_profile.dart';
import '../screens/screen_31_event_details.dart';
import '../screens/screen_32_register.dart';
import '../screens/screen_33_check_in.dart';
import '../screens/screen_34_generate_certificates.dart';
import '../screens/screen_35_vendor_directory.dart';
import '../screens/screen_36_photography_category.dart';
import '../screens/screen_37_vendor_profile.dart';
import '../screens/screen_38_vendor_reviews.dart';
import '../screens/screen_39_review_vendor.dart';
import '../screens/screen_40_discover_events.dart';
import '../screens/screen_41_event_details.dart';
import '../screens/screen_42_register_event.dart';
import '../screens/screen_43_checkout.dart';
import '../screens/screen_44_registration_success.dart';
import '../screens1-22/screen_10_discover.dart';
import '../screens1-22/screen_11_notification_settings.dart';
import '../screens1-22/screen_12_my_certificates.dart';
import '../screens1-22/screen_13_certificate_details.dart';
import '../screens1-22/screen_14_settings.dart';
import '../screens1-22/screen_15_discover_list.dart';
import '../screens1-22/screen_16_analytics_dashboard.dart';
import '../screens1-22/screen_17_my_events.dart';
import '../screens1-22/screen_18_notifications.dart';
import '../screens1-22/screen_19_create_event_step_1.dart';
import '../screens1-22/screen_1_splash.dart';
import '../screens1-22/screen_20_dashboard.dart';
import '../screens1-22/screen_21_create_event_step_2.dart';
import '../screens1-22/screen_22_create_event_step_3.dart';
import '../screens1-22/screen_2_onboarding_1.dart';
import '../screens1-22/screen_3_onboarding_2.dart';
import '../screens1-22/screen_4_login.dart';
import '../screens1-22/screen_5_sign_up.dart';
import '../screens1-22/screen_6_forgot_password.dart';
import '../screens1-22/screen_7_set_up_profile.dart';
import '../screens1-22/screen_8_profile.dart';
import '../screens1-22/screen_9_edit_profile.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/review',
        name: 'review',
        builder: (context, state) => const Screen24Review(),
      ),
      GoRoute(
        path: '/eventDetails',
        name: 'eventDetails',
        builder: (context, state) => const Screen25EventDetails(),
      ),
      GoRoute(
        path: '/eventOverview',
        name: 'eventOverview',
        builder: (context, state) => const Screen26EventOverview(),
      ),
      GoRoute(
        path: '/attendees',
        name: 'attendees',
        builder: (context, state) => const Screen27Attendees(),
      ),
      GoRoute(
        path: '/analytics',
        name: 'analytics',
        builder: (context, state) => const Screen29Analytics(),
      ),
      GoRoute(
        path: '/speakerProfile',
        name: 'speakerProfile',
        builder: (context, state) => const Screen30SpeakerProfile(),
      ),
      GoRoute(
        path: '/eventDetails31',
        name: 'eventDetails31',
        builder: (context, state) => const Screen31EventDetails(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const Screen32Register(),
      ),
      GoRoute(
        path: '/checkIn',
        name: 'checkIn',
        builder: (context, state) => const Screen33CheckIn(),
      ),
      GoRoute(
        path: '/generateCertificates',
        name: 'generateCertificates',
        builder: (context, state) => const Screen34GenerateCertificates(),
      ),
      GoRoute(
        path: '/vendorDirectory',
        name: 'vendorDirectory',
        builder: (context, state) => const Screen35VendorDirectory(),
      ),
      GoRoute(
        path: '/photographyCategory',
        name: 'photographyCategory',
        builder: (context, state) => const Screen36PhotographyCategory(),
      ),
      GoRoute(
        path: '/vendorProfile',
        name: 'vendorProfile',
        builder: (context, state) => const Screen37VendorProfile(),
      ),
      GoRoute(
        path: '/vendorReviews',
        name: 'vendorReviews',
        builder: (context, state) => const Screen38VendorReviews(),
      ),
      GoRoute(
        path: '/reviewVendor',
        name: 'reviewVendor',
        builder: (context, state) => const Screen39ReviewVendor(),
      ),
      GoRoute(
        path: '/discoverEvents',
        name: 'discoverEvents',
        builder: (context, state) => const Screen40DiscoverEvents(),
      ),
      GoRoute(
        path: '/eventDetails41',
        name: 'eventDetails41',
        builder: (context, state) => const Screen41EventDetails(),
      ),
      GoRoute(
        path: '/registerEvent',
        name: 'registerEvent',
        builder: (context, state) => const Screen42RegisterEvent(),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const Screen43Checkout(),
      ),
      GoRoute(
        path: '/registrationSuccess',
        name: 'registrationSuccess',
        builder: (context, state) => const Screen44RegistrationSuccess(),
      ),
      GoRoute(
        path: '/discover',
        name: 'discover',
        builder: (context, state) => const Screen10Discover(),
      ),
      GoRoute(
        path: '/notificationSettings',
        name: 'notificationSettings',
        builder: (context, state) => const Screen11NotificationSettings(),
      ),
      GoRoute(
        path: '/myCertificates',
        name: 'myCertificates',
        builder: (context, state) => const Screen12MyCertificates(),
      ),
      GoRoute(
        path: '/certificateDetails',
        name: 'certificateDetails',
        builder: (context, state) => const Screen13CertificateDetails(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const Screen14Settings(),
      ),
      GoRoute(
        path: '/discoverList',
        name: 'discoverList',
        builder: (context, state) => const Screen15DiscoverList(),
      ),
      GoRoute(
        path: '/analyticsDashboard',
        name: 'analyticsDashboard',
        builder: (context, state) => const Screen16AnalyticsDashboard(),
      ),
      GoRoute(
        path: '/myEvents',
        name: 'myEvents',
        builder: (context, state) => const Screen17MyEvents(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const Screen18Notifications(),
      ),
      GoRoute(
        path: '/createEventStep1',
        name: 'createEventStep1',
        builder: (context, state) => const Screen19CreateEventStep1(),
      ),
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const Screen1Splash(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const Screen20Dashboard(),
      ),
      GoRoute(
        path: '/createEventStep2',
        name: 'createEventStep2',
        builder: (context, state) => const Screen21CreateEventStep2(),
      ),
      GoRoute(
        path: '/createEventStep3',
        name: 'createEventStep3',
        builder: (context, state) => const Screen22CreateEventStep3(),
      ),
      GoRoute(
        path: '/createEventStep4',
        name: 'createEventStep4',
        builder: (context, state) => const RegistrationSetupScreen(),
      ),
      GoRoute(
        path: '/onboarding1',
        name: 'onboarding1',
        builder: (context, state) => const Screen2Onboarding1(),
      ),
      GoRoute(
        path: '/onboarding2',
        name: 'onboarding2',
        builder: (context, state) => const Screen3Onboarding2(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const Screen4Login(),
      ),
      GoRoute(
        path: '/signUp',
        name: 'signUp',
        builder: (context, state) => const Screen5SignUp(),
      ),
      GoRoute(
        path: '/forgotPassword',
        name: 'forgotPassword',
        builder: (context, state) => const Screen6ForgotPassword(),
      ),
      GoRoute(
        path: '/setUpProfile',
        name: 'setUpProfile',
        builder: (context, state) => const Screen8SetUpProfile(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const Screen7Profile(),
      ),
      GoRoute(
        path: '/editProfile',
        name: 'editProfile',
        builder: (context, state) => const Screen9EditProfile(),
      ),
    ],
  );
});
