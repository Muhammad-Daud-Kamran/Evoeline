import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/agenda_timeline_item.dart';
import '../widgets/speaker_avatar_item.dart';
import '../viewmodels/event_viewmodel.dart';
import '../viewmodels/agenda_viewmodel.dart';
import '../viewmodels/speaker_viewmodel.dart';

/// Screen 31: Event Details (Attendee View)
/// This screen uses three independent providers:
/// 1. eventProvider   → For the main event information (Header, Hero image, Venue)
/// 2. agendaProvider  → For the Agenda timeline section
/// 3. speakerProvider → For the Speakers horizontal list
class Screen31EventDetails extends ConsumerWidget {
  const Screen31EventDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ── STEP 1: WATCH THE PROVIDERS ──────────────────
    final eventState = ref.watch(eventProvider);
    final agendaState = ref.watch(agendaProvider);
    final speakerState = ref.watch(speakerProvider);

    // If any core data is loading, show a loader
    if (eventState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    final event = eventState.event;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share, color: AppColors.darkText),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sharing coming soon')),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.check_circle, color: AppColors.successGreen),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Saved locally'))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── STEP 2: DYNAMIC HEADER ──────────────────────
            Text(
              event.title,
              style: AppTextStyles.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              event.shortDescription,
              style: AppTextStyles.label,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Info Chips (Schedule & Location)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildInfoChip(Icons.calendar_today, event.startDate),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.access_time,
                      '${event.startTime} - ${event.endTime}',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoChip(Icons.location_on_outlined, event.venueName),
              ],
            ),
            const SizedBox(height: 24),

            // Register Button
            ElevatedButton.icon(
              onPressed: () => context.pushNamed('registerEvent'),
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
                image: DecorationImage(
                  image: AssetImage(event.bannerImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // ── STEP 3: DYNAMIC AGENDA ──────────────────────
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Agenda', style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 16),
            if (agendaState.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ...agendaState.items.map(
                (item) => AgendaTimelineItem(
                  title: item.title,
                  time: item.time,
                  isLast: item.isLast,
                ),
              ),
            const SizedBox(height: 32),

            // ── STEP 4: DYNAMIC SPEAKERS ────────────────────
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Speakers', style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: speakerState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: speakerState.speakers.length,
                      itemBuilder: (context, index) {
                        final speaker = speakerState.speakers[index];
                        return SpeakerAvatarItem(
                          name: speaker.name,
                          role: speaker.designation,
                          avatarColor: index == 0
                              ? AppColors.avatarGreen1
                              : (index == 1
                                    ? AppColors.avatarGreen2
                                    : AppColors.avatarGrey),
                          imagepath: speaker.profileImage,
                        );
                      },
                    ),
            ),
            const SizedBox(height: 32),

            // Sponsors Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Sponsors', style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: event.sponsors
                    .map((s) => _buildSponsorCard(s))
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),

            // Venue Information
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Venue Information', style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(event.address, style: AppTextStyles.bodyText),
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Action Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _BuildActionIcon(svgPath: 'assets/images/whatsapp.svg'),
                const SizedBox(width: 24),
                const _BuildActionIcon(svgPath: 'assets/images/linkedin.svg'),
                const SizedBox(width: 24),
                const _BuildActionIcon(svgPath: 'assets/images/facebook.svg'),
                const SizedBox(width: 24),
                const _BuildActionIcon(svgPath: 'assets/images/link.svg'),
              ],
            ),
            const SizedBox(height: 48),

            // Back Button
            TextButton(
              onPressed: () => context.pop(),
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

  // Helper for Sponsor Cards
  Widget _buildSponsorCard(String name) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.business, color: AppColors.lightText, size: 24),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
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
