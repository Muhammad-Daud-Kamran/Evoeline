import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/speaker_session_item.dart';
import '../widgets/past_event_card.dart';

/// Screen 30: Speaker Profile
class Screen30SpeakerProfile extends StatelessWidget {
  const Screen30SpeakerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Speaker Profile', style: AppTextStyles.heading2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share, color: AppColors.darkText),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.cardBackground, // Peach background
              backgroundImage: AssetImage('assets/images/screen30speakerprofile.jpg'),
            ),
            const SizedBox(height: 16),

            // Name and Title
            const Text('Dr. Anya Sharma', style: AppTextStyles.heading2),
            const SizedBox(height: 4),
            Text(
              'Chief Innovation Officer\nInnovateTech Solutions',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText.copyWith(
                color: AppColors.lightText,
              ), 
            ),
            const SizedBox(height: 24),

            // Social Links Row - Changed to Row to align horizontally
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialLink(
                  svgPath: 'assets/images/linkedin.svg',
                  label: 'LinkedIn',
                ),
                const SizedBox(height: 34),
                _SocialLink(
                  svgPath: 'assets/images/twitter.svg',
                  label: 'Twitter',
                ),
                const SizedBox(height: 34),
                _SocialLink(
                  svgPath: 'assets/images/website.svg',
                  label: 'Website',
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Main Picture Container
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 340,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.lightGreyBackground,
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/screen30image2.jpg'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Sessions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sessions', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  const SpeakerSessionItem(
                    title: 'The Future of Tech Innovation',
                    dateTime: 'July 15, 2024 · 2:00 PM',
                    imagePath: 'assets/images/screen30image3.png',
                    isLive: true,
                  ),
                  const SpeakerSessionItem(
                    title: 'Building Sustainable Solutions',
                    dateTime: 'July 16, 2024 · 10:00 AM',
                    imagePath: 'assets/images/screen30image4.jpg',
                    isLive: true,
                  ),
                  const SizedBox(height: 32),

                  // Past Events Section
                  const Text('Past Events', style: AppTextStyles.heading2),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200, // Increased height to prevent overflow
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        PastEventCard(
                            imagePath: 'assets/images/screen30image5.jpg',
                            title: 'Tech Summit 2023',
                            year: '2023'),
                        PastEventCard(
                          title: 'Innovate Conference 2022',
                          imagePath: 'assets/images/screen30image6.jpg',
                          year: '2022',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Actions
                  CustomButton(
                    text: 'Add to Event',
                    onPressed: () {},
                    backgroundColor: AppColors.primaryGreen,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Contact Speaker',
                    onPressed: () {},
                    backgroundColor: AppColors.lightGreyBackground,
                    textColor: AppColors.darkText,
                  ),
                  const SizedBox(height: 24),

                  // Share Profile Link
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Share Profile',
                        style: TextStyle(
                          color: AppColors.darkText,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.lightText,
        currentIndex: 2, 
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic_none),
            label: 'Speakers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _SocialLink extends StatelessWidget {
  final String svgPath;
  final String label;

  const _SocialLink({super.key, required this.svgPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: AppColors.lightGreyBackground,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            svgPath,
            colorFilter: const ColorFilter.mode(
              AppColors.darkText,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.darkText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
