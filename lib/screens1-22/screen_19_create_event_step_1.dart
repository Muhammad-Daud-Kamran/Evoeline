import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class Screen19CreateEventStep1 extends StatefulWidget {
  const Screen19CreateEventStep1({super.key});

  @override
  State<Screen19CreateEventStep1> createState() =>
      _Screen19CreateEventStep1State();
}

class _Screen19CreateEventStep1State extends State<Screen19CreateEventStep1> {
  String selectedType = 'Conference';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.darkText),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            const Text(
              'Step 1 of 5',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(height: 4, color: AppColors.primaryGreen),
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
            const SizedBox(height: 16),
            const Text(
              'Basic Information',
              style: TextStyle(color: AppColors.primaryGreen, fontSize: 12),
            ),
            const SizedBox(height: 24),

            // Select Event Type
            const Text('Select Event Type', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: [
                _buildEventTypeCard('Conference', const Color(0xFFD6BFAF)),
                _buildEventTypeCard('Seminar', const Color(0xFFEBEBEB)),
                _buildEventTypeCard('Workshop', const Color(0xFF1E3D33)),
                _buildEventTypeCard('Training', const Color(0xFF2E4E42)),
                _buildEventTypeCard('Networking', const Color(0xFFF0EAE3)),
                _buildEventTypeCard(
                  'Custom',
                  const Color(0xFFE8DAC),
                  isTextDark: true,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Form Fields
            const Text(
              'Event Title',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.searchBarFillColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Event Title',
                  hintStyle: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Event Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.searchBarFillColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.searchBarFillColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Category',
                  hintStyle: TextStyle(color: AppColors.darkText, fontSize: 14),
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.darkText,
                  ),
                ),
                enabled: false, // Dropdown placeholder
              ),
            ),
            const SizedBox(height: 24),

            // Upload Banner
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.lightGreyBackground,
                  width: 2,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              // Using a simple Dashed Rect simulation for ease
              child: CustomPaint(
                painter: const DashedRectPainter(
                  color: AppColors.lightGreyBackground,
                ),
                child: const Center(
                  child: Text(
                    'Upload event banner image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.darkText,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(color: AppColors.lightGreyBackground),
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
              onPressed: () => context.pushNamed('createEventStep2'),
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

  Widget _buildEventTypeCard(
    String title,
    Color imageColor, {
    bool isTextDark = false,
  }) {
    bool isSelected = selectedType == title;
    return GestureDetector(
      onTap: () => setState(() => selectedType = title),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120, // adjust as needed
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: AppColors.primaryGreen, width: 2)
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: isTextDark ? AppColors.darkText : AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  final Color color;
  const DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 8, dashSpace = 4;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    // Simple implementation - drawing continuous path as dashes may require more complex path metric calculation in generic Flutter
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
