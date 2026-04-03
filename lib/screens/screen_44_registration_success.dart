import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';
import '../viewmodels/registration_success_viewmodel.dart';

/// Screen 44: Registration Success (MVVM Architecture)
class Screen44RegistrationSuccess extends ConsumerWidget {
  const Screen44RegistrationSuccess({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationSuccessProvider);

    if (state.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    if (state.errorMessage.isNotEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text(
            state.errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    final event = state.event;
    final reg = state.registration;

    // Format the event type label
    final formatLabel = event.format == 'virtual' ? 'Online' : 'In-person';

    // Displayed schedule line
    final scheduleText =
        '${event.startDate} · ${event.startTime} – ${event.endTime}';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.darkText),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Success Graphic ──────────────────────────
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    event.bannerImage.isNotEmpty
                        ? event.bannerImage
                        : 'assets/images/s44image1.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // ── Success Header ───────────────────────
                  const Text(
                    '🎉 You\'re Registered!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your spot is confirmed for this event.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Event Details ────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatLabel,
                              style: const TextStyle(
                                color: AppColors.primaryGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              event.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.darkText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              scheduleText,
                              style: const TextStyle(
                                color: AppColors.lightText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFF192F2D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.emoji_events,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Registration ID
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Registration ID: #${reg.registrationId}',
                      style: const TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── QR Code ─────────────────────────────
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF3E2C4), Color(0xFFC39C74)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(
                          reg.qrCodeImageUrl.isNotEmpty
                              ? reg.qrCodeImageUrl
                              : 'assets/images/s44image2.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Action Buttons ───────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to Calendar'),
                                ),
                              ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.darkText,
                            backgroundColor: AppColors.lightGreyBackground,
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Add to Calendar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Opening Share Menu'),
                                ),
                              ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Share with Friends',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // ── What's Next? ─────────────────────────
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What\'s Next?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildNextStepItem(
                    Icons.mail_outline,
                    'Email Confirmation',
                    'Check your email for a confirmation message and event details.',
                  ),
                  _buildNextStepItem(
                    Icons.stay_current_portrait,
                    'Event App',
                    'Download the Event App to manage your tickets and schedule.',
                  ),
                  _buildNextStepItem(
                    Icons.people_outline,
                    'Event Community',
                    'Join the Event Community to connect with other attendees.',
                  ),
                  const SizedBox(height: 24),

                  // ── Bottom Buttons ───────────────────────
                  CustomButton(
                    text: 'View My Events',
                    onPressed: () => context.goNamed('dashboard'),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: TextButton(
                      onPressed: () => context.pop(),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.lightGreyBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          color: AppColors.darkText,
                          fontWeight: FontWeight.bold,
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

      // Bottom Nav Bar
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              'assets/images/s32icon1home.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 46,
              height: 46,
            ),
            SvgPicture.asset(
              'assets/images/s41iconeventbold.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.darkText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s32icon3tickets.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.primaryGreen,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              'assets/images/s32icon4profile.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.lightText,
                BlendMode.srcIn,
              ),
              width: 44,
              height: 44,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextStepItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.darkText, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
