import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Import screens
import '../screens1-22/screen_1_splash.dart';
import '../screens1-22/screen_2_onboarding_1.dart';
import '../screens1-22/screen_3_onboarding_2.dart';
import '../screens1-22/screen_4_login.dart';
import '../screens1-22/screen_5_sign_up.dart';
import '../screens1-22/screen_6_forgot_password.dart';
import '../screens1-22/screen_20_dashboard.dart';
import '../screens1-22/screen_17_my_events.dart';
import '../screens1-22/screen_16_analytics_dashboard.dart';
import '../screens1-22/screen_12_my_certificates.dart';
import '../screens1-22/screen_14_settings.dart';
import '../screens/screen_35_vendor_directory.dart';
import '../screens/screen_25_event_details.dart';

// Create a provider for the router so it can be accessed and react to auth state if needed
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const Screen1Splash(),
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
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const Screen5SignUp(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgotPassword',
        builder: (context, state) => const Screen6ForgotPassword(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const Screen20Dashboard(),
      ),
      GoRoute(
        path: '/my-events',
        name: 'myEvents',
        builder: (context, state) => const Screen17MyEvents(),
      ),
      GoRoute(
        path: '/analytics',
        name: 'analytics',
        builder: (context, state) => const Screen16AnalyticsDashboard(),
      ),
      GoRoute(
        path: '/certificates',
        name: 'certificates',
        builder: (context, state) => const Screen12MyCertificates(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const Screen14Settings(),
      ),
      GoRoute(
        path: '/vendors',
        name: 'vendors',
        builder: (context, state) => const Screen35VendorDirectory(),
      ),
      GoRoute(
        path: '/event-details',
        name: 'eventDetails',
        builder: (context, state) => const Screen25EventDetails(),
      ),
    ],
  );
});
