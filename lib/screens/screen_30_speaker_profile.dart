import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/speaker_session_item.dart';
import '../widgets/past_event_card.dart';
import '../viewmodels/speaker_viewmodel.dart';

/// Screen 30: Speaker Profile
class Screen30SpeakerProfile extends ConsumerWidget {
  const Screen30SpeakerProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the state from our new ViewModel
    final speakerState = ref.watch(speakerProvider);
    final data = speakerState.speaker;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
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
      body: speakerState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.cardBackground, // Peach background
              // 2. Use image from the model
              backgroundImage: AssetImage(data.profileImage.isNotEmpty ? data.profileImage : 'assets/images/screen30speakerprofile.jpg'),
            ),
            const SizedBox(height: 16),

            // Name and Title
            Text(data.name.isEmpty ? 'Loading Name...' : data.name, style: AppTextStyles.heading2),
            const SizedBox(height: 4),
            Text(
              data.designation.isEmpty ? 'Loading Designation...' : data.designation,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText.copyWith(
                color: AppColors.lightText,
              ),
            ),
            const SizedBox(height: 24),

            // Social Links Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialLink(
                  svgPath: 'assets/images/linkedin.svg',
                  label: 'LinkedIn',
                ),
                const SizedBox(width: 40), 
                _SocialLink(
                  svgPath: 'assets/images/twitter.svg',
                  label: 'Twitter',
                ),
                const SizedBox(width: 40),
                _SocialLink(
                  svgPath: 'assets/images/website.svg',
                  label: 'Website',
                ),
              ],
            ),
            const SizedBox(height: 32),

            // NEW: Bio Section (Schema: bio)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('About Speaker', style: AppTextStyles.heading3),
                  const SizedBox(height: 8),
                  Text(
                    data.bio.isEmpty ? 'Loading bio...' : data.bio,
                    style: AppTextStyles.bodyText.copyWith(
                      color: AppColors.darkText,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
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
                  // Render Sessions dynamically from model
                  ...data.sessions.map((session) => SpeakerSessionItem(
                    title: session.title,
                    dateTime: session.dateTime,
                    imagePath: session.imagePath,
                    isLive: session.isLive,
                  )).toList(),
                  const SizedBox(height: 32),

                  // Past Events Section
                  const Text('Past Events', style: AppTextStyles.heading2),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 220, 
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      // Render Past Events dynamically from model
                      children: data.pastEvents.map((event) => PastEventCard(
                        title: event.title,
                        year: event.year,
                        imagePath: event.imagePath,
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 36),

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
