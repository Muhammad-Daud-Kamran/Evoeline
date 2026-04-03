import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/custom_button.dart';

class Screen11NotificationSettings extends StatefulWidget {
  const Screen11NotificationSettings({super.key});

  @override
  State<Screen11NotificationSettings> createState() =>
      _Screen11NotificationSettingsState();
}

class _Screen11NotificationSettingsState
    extends State<Screen11NotificationSettings> {
  // Event Updates
  bool newEventInvitations = true;
  bool eventReminders = true;
  bool eventCancellations = false;
  bool scheduleChanges = false;

  // Marketing Preferences
  bool promotionalEmails = false;
  bool featureUpdates = false;
  bool tipsAndTricks = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Notification Settings',
          style: AppTextStyles.heading2,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Event Updates', style: AppTextStyles.heading2),
              const SizedBox(height: 16),
              _buildToggleItem(
                'New Event Invitatio...',
                Icons.email_outlined,
                newEventInvitations,
                (val) => setState(() => newEventInvitations = val),
              ),
              _buildToggleItem(
                'Event Reminde...',
                Icons.notifications_none,
                eventReminders,
                (val) => setState(() => eventReminders = val),
              ),
              _buildToggleItem(
                'Event Cancellations',
                Icons.close,
                eventCancellations,
                (val) => setState(() => eventCancellations = val),
              ),
              _buildToggleItem(
                'Schedule Changes',
                Icons.calendar_today_outlined,
                scheduleChanges,
                (val) => setState(() => scheduleChanges = val),
              ),

              const SizedBox(height: 32),
              const Text(
                'Marketing Preferences',
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: 16),
              _buildToggleItem(
                'Promotional Emails',
                Icons.campaign_outlined,
                promotionalEmails,
                (val) => setState(() => promotionalEmails = val),
              ),
              _buildToggleItem(
                'Feature Updat...',
                Icons.star_outline,
                featureUpdates,
                (val) => setState(() => featureUpdates = val),
              ),
              _buildToggleItem(
                'Tips and Tricks',
                Icons.lightbulb_outline,
                tipsAndTricks,
                (val) => setState(() => tipsAndTricks = val),
              ),

              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Save Preferences',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preferences saved')),
                    );
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleItem(
    String title,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.darkText, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: AppTextStyles.bodyText)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.primaryGreen,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.dividerColor,
          ),
        ],
      ),
    );
  }
}
