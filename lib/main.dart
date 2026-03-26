

import 'package:evoeline/screens/screen_30_speaker_profile.dart';
import 'package:evoeline/screens/screen_31_event_details.dart';
import 'package:evoeline/screens/screen_32_register.dart';
import 'package:evoeline/screens/screen_33_check_in.dart';
import 'package:evoeline/screens/screen_34_generate_certificates.dart';
import 'package:evoeline/screens/screen_35_vendor_directory.dart';
import 'package:evoeline/screens/screen_37_vendor_profile.dart';
import 'package:evoeline/screens/screen_38_vendor_reviews.dart';
import 'package:evoeline/screens/screen_39_review_vendor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(const ProviderScope( // ← MUST wrap entire app
    child: MyApp(),
  ),);
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
          const Screen39ReviewVendor(), // 👈 Changed to the latest screen
    );
  }
}
