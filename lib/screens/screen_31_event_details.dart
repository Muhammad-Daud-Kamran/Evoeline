import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/agenda_timeline_item.dart';
import '../widgets/speaker_avatar_item.dart';

/// Screen 31: Event Details / Tech Summit 2024
class Screen31EventDetails extends StatelessWidget {
  const Screen31EventDetails({Key? key}) : super(key: key);

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
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share, color: AppColors.darkText),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.check_circle,
              color: AppColors.successGreen,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Info
            const Text(
              'Tech Summit 2024',
              style: AppTextStyles.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Innovate, Connect, Transform',
              style: AppTextStyles.label,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Info Chips
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildInfoChip(Icons.calendar_today, 'Oct 20, 2024'),
                    const SizedBox(width: 8),
                    _buildInfoChip(Icons.access_time, '9:00 AM - 5:00 PM'),
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoChip(
                  Icons.location_on_outlined,
                  'FAST University, Lahore',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Register Button
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.check, size: 20),
              label: const Text(
                'Register Now',
                style: AppTextStyles.buttonText,
              ),
            ),
            const SizedBox(height: 24),

            // Hero Image
            Container(
              height: 370,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.heroPlaceholderDark,
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/screen31image1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Agenda
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Agenda', style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 16),
            const AgendaTimelineItem(
              title: 'Opening Keynote',
              time: '10:00 AM - 11:00 AM',
            ),
            const AgendaTimelineItem(
              title: 'Panel Discussion: Future of AI',
              time: '11:30 AM - 12:30 PM',
            ),
            const AgendaTimelineItem(
              title: 'Networking Lunch',
              time: '12:30 PM - 1:30 PM',
              isLast: true,
            ),
            const SizedBox(height: 32),

            // Speakers
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Speakers', style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SpeakerAvatarItem(
                    name: 'Ethan Carter',
                    role: 'CEO, TechCorp',
                    avatarColor: AppColors.avatarGreen1,
                    imagepath: 'assets/images/screen31circularimage1.jpg',
                  ),
                  SpeakerAvatarItem(
                    name: 'Sophia Bennett',
                    role: 'CTO, InnovateAI',
                    avatarColor: AppColors.avatarGreen2,
                    imagepath: 'assets/images/screen31circularimage2.jpg',
                  ),
                  SpeakerAvatarItem(
                    name: 'Liam',
                    role: 'Future..',
                    avatarColor: AppColors.avatarGrey,
                    imagepath: 'assets/images/screen31circularimage3.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Venue Information
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Venue Information', style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Main Hall, FAST University, Lahore',
                style: AppTextStyles.bodyText,
              ),
            ),
            const SizedBox(height: 16),

            // View on Map
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.lightGreyBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.darkText,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'View on Map',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Action Icons — pass your svg paths here 👇
            const _BuildActionIcon(svgPath: 'assets/images/whatsapp.svg'),
            const SizedBox(height: 24),
            const _BuildActionIcon(svgPath: 'assets/images/linkedin.svg'),
            const SizedBox(height: 24),
            const _BuildActionIcon(svgPath: 'assets/images/facebook.svg'),
            const SizedBox(height: 24),
            const _BuildActionIcon(svgPath: 'assets/images/link.svg'),
            const SizedBox(height: 48),

            // Back Button
            TextButton(
              onPressed: () {},
              child: const Text(
                'Back to Dashboard',
                style: TextStyle(
                  color: AppColors.darkText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Info Chip helper method
  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.iconColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.darkText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildActionIcon extends StatelessWidget {
  final String svgPath;
  const _BuildActionIcon({required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: AppColors.lightGreyBackground,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.dividerColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          svgPath,
          colorFilter: const ColorFilter.mode(
            AppColors.darkText,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
