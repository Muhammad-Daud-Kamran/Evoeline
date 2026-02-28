
import 'package:evoeline/screens/screen_30_speaker_profile.dart';
import 'package:evoeline/screens/screen_31_event_details.dart';
import 'package:evoeline/screens/screen_32_register.dart';
import 'package:evoeline/screens/screen_33_check_in.dart';
import 'package:flutter/material.dart';

// Import your screen here
// import 'features/home/screens/home_screen.dart';

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
          const Screen33CheckIn(), // 👈 Just replace this with any screen
    );
  }
}
