import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Screen22CreateEventStep3 extends StatefulWidget {
  const Screen22CreateEventStep3({super.key});

  @override
  State<Screen22CreateEventStep3> createState() =>
      _Screen22CreateEventStep3State();
}

class _Screen22CreateEventStep3State extends State<Screen22CreateEventStep3> {
  String selectedFormat = 'Physical';
  String? selectedCity;
  final List<String> cities = [
    'San Francisco',
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
  ];

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
        title: const Text(
          'Step 3 of 5',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkText,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Row(
              children: [
                Expanded(
                  child: Container(height: 4, color: AppColors.darkText),
                ), // Use dark text for completed steps in this screen
                const SizedBox(width: 4),
                Expanded(
                  child: Container(height: 4, color: AppColors.darkText),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(height: 4, color: AppColors.darkText),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 4,
                    color: AppColors.lightGreyBackground,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 4,
                    color: AppColors.lightGreyBackground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text(
              'Event Location & Format',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose how and where your attendees will join the event.',
              style: AppTextStyles.bodyText,
            ),
            const SizedBox(height: 24),

            // Format Toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.lightGreyBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(child: _buildFormatTab('Physical')),
                  Expanded(child: _buildFormatTab('Virtual')),
                  Expanded(child: _buildFormatTab('Hybrid')),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Form Fields
            const Text(
              'Venue Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            _buildInputField('Venue\nName'),
            const SizedBox(height: 16),

            const Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter full venue address',
                  hintStyle: TextStyle(color: AppColors.lightText, fontSize: 14),
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'City',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                initialValue: selectedCity,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Select City',
                  hintStyle: TextStyle(color: AppColors.darkText, fontSize: 14),
                ),
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.darkText),
                items: cities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCity = newValue;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            // Map Image
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/Screen_22.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // A standard red map pin
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                  Positioned(
                    top: 45, // Adjusted to gracefully sit above the pin
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Text(
                        'San Francisco',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Drag pin to set precise venue location.',
                style: AppTextStyles.bodyText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Capacity',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            _buildInputField('Number\nof people', keyboardType: TextInputType.number),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.searchBarFillColor,
                foregroundColor: AppColors.darkText,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Back',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.pushNamed('createEventStep4'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatTab(String label) {
    bool isSelected = selectedFormat == label;
    return GestureDetector(
      onTap: () => setState(() => selectedFormat = label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.darkText : AppColors.lightText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintMaxLines: 2,
          hintStyle: const TextStyle(
            color: AppColors.primaryGreen,
            fontSize: 14,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
