import 'package:evoeline/screens/screen_39_review_vendor.dart';
import 'package:evoeline/screens/screen_40_discover_events.dart';
import 'package:evoeline/screens/screen_41_event_details.dart';
import 'package:evoeline/screens/screen_42_register_event.dart';
import 'package:evoeline/screens/screen_43_checkout.dart';
import 'package:evoeline/screens/screen_44_registration_success.dart';
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
          const Screen44RegistrationSuccess(), // 👈 Changed to the latest screen
    );
  }
}
