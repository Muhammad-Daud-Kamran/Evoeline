
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

      home:
          const Screen44RegistrationSuccess(), // 👈 Changed to the latest screen
    );
  }
}
