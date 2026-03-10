import 'package:evoeline/screens/screen_23_registration.dart';
import 'package:evoeline/screens/screen_24_review.dart';
import 'package:evoeline/screens/screen_25_event_details.dart';
import 'package:evoeline/screens/screen_26_event_overview.dart';
import 'package:evoeline/screens/screen_27_attendees.dart';
import 'package:evoeline/screens/screen_29_analytics.dart';
import 'package:evoeline/screens/screen_30_speaker_profile.dart';
import 'package:evoeline/screens/screen_31_event_details.dart';
import 'package:evoeline/screens/screen_32_register.dart';
import 'package:evoeline/screens/screen_33_check_in.dart';
import 'package:evoeline/screens/screen_34_generate_certificates.dart';
import 'package:evoeline/screens/screen_35_vendor_directory.dart';
import 'package:evoeline/screens/screen_36_photography_category.dart';
import 'package:evoeline/screens/screen_37_vendor_profile.dart';
import 'package:evoeline/screens/screen_38_vendor_reviews.dart';
import 'package:evoeline/screens/screen_39_review_vendor.dart';
import 'package:evoeline/screens/screen_40_discover_events.dart';
import 'package:evoeline/screens/screen_41_event_details.dart';
import 'package:evoeline/screens/screen_42_register_event.dart';
import 'package:evoeline/screens/screen_43_checkout.dart';
import 'package:evoeline/screens/screen_44_registration_success.dart';
import 'package:evoeline/screens1-22/screen_1_splash.dart';
import 'package:evoeline/screens1-22/screen_2_onboarding_1.dart';
import 'package:evoeline/screens1-22/screen_10_discover.dart';
import 'package:evoeline/screens1-22/screen_11_notification_settings.dart';
import 'package:evoeline/screens1-22/screen_12_my_certificates.dart';
import 'package:evoeline/screens1-22/screen_13_certificate_details.dart';
import 'package:evoeline/screens1-22/screen_14_settings.dart';
import 'package:evoeline/screens1-22/screen_15_discover_list.dart';
import 'package:evoeline/screens1-22/screen_16_analytics_dashboard.dart';
import 'package:evoeline/screens1-22/screen_17_my_events.dart';
import 'package:evoeline/screens1-22/screen_18_notifications.dart';
import 'package:evoeline/screens1-22/screen_19_create_event_step_1.dart';
import 'package:evoeline/screens1-22/screen_20_dashboard.dart';
import 'package:evoeline/screens1-22/screen_21_create_event_step_2.dart';
import 'package:evoeline/screens1-22/screen_22_create_event_step_3.dart';
import 'package:evoeline/screens1-22/screen_3_onboarding_2.dart';
import 'package:evoeline/screens1-22/screen_6_forgot_password.dart';
import 'package:evoeline/screens1-22/screen_7_set_up_profile.dart';
import 'package:evoeline/screens1-22/screen_8_profile.dart';
import 'package:evoeline/widgets/discover_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const Screen8SetUpProfile(), // 👈 Changed to the latest screen
    );
  }
}
