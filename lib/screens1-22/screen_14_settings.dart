import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Screen14Settings extends StatefulWidget {
  const Screen14Settings({super.key});

  @override
  State<Screen14Settings> createState() => _Screen14SettingsState();
}

class _Screen14SettingsState extends State<Screen14Settings> {
  bool emailNotifications = false;
  bool smsNotifications = false;
  bool eventReminders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
        title: const Text('Settings', style: AppTextStyles.heading2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Top Illustration Placeholder
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFD7CCC8),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 24),

            _buildListTile('Email Preferences', Icons.email_outlined),
            _buildListTile('Phone Verification', Icons.phone_outlined),
            _buildListTile(
              'Two-Factor Authenticati...',
              Icons.shield_outlined,
              trailingText: 'Enabled',
            ),

            const SizedBox(height: 24),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFCFD8DC),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 24),

            _buildToggleTile(
              'Email Notifications',
              emailNotifications,
              (v) => setState(() => emailNotifications = v),
            ),
            _buildToggleTile(
              'SMS Notifications',
              smsNotifications,
              (v) => setState(() => smsNotifications = v),
            ),
            _buildToggleTile(
              'Event Reminders',
              eventReminders,
              (v) => setState(() => eventReminders = v),
            ),

            const SizedBox(height: 24),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFD7CCC8),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 24),

            _buildDropdownTile('Timezone', 'GMT+5'),
            _buildDropdownTile('Date Format', 'MM/DD/YYYY'),
            _buildDropdownTile('Currency', 'PKR'),

            const SizedBox(height: 24),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFBCAAA4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 24),

            _buildInfoTile('Data Sharing Preferences', Icons.info_outline),

            const SizedBox(height: 24),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFCFD8DC),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 24),

            _buildListTile('Terms of Service', Icons.description_outlined),
            _buildListTile('Privacy Policy', Icons.shield_outlined),
            _buildListTile('About EventFlo...', Icons.info_outline),
            _buildListTile('Contact Supp...', Icons.email_outlined),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.analyticsLightGreen,
                foregroundColor: AppColors.darkText,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Delete Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, {String? trailingText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
          if (trailingText != null)
            Text(
              trailingText,
              style: const TextStyle(fontSize: 14, color: AppColors.darkText),
            )
          else
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.lightText,
            ),
        ],
      ),
    );
  }

  Widget _buildToggleTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.bodyText),
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

  Widget _buildDropdownTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.bodyText),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: AppColors.darkText),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, IconData trailingIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.bodyText),
          Icon(trailingIcon, size: 20, color: AppColors.darkText),
        ],
      ),
    );
  }
}
