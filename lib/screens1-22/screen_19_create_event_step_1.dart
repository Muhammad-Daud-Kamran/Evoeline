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
  String? selectedCategory;
  final List<String> categories = ['Technology', 'Business', 'Art', 'Music', 'Health'];

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
              mainAxisSpacing: 8, // Reduced from 16
              childAspectRatio: 1.1, // Increased from 0.85 to reduce vertical dead space in each cell
              children: [
                _buildEventTypeCard('Conference', 'assets/images/Screen_19_1.png'),
                _buildEventTypeCard('Seminar', 'assets/images/Screen_19_2.png'),
                _buildEventTypeCard('Workshop', 'assets/images/Screen_19_6.png'),
                _buildEventTypeCard('Training', 'assets/images/Screen_19_3.png'),
                _buildEventTypeCard('Networking', 'assets/images/Screen_19_4.png'),
                _buildEventTypeCard(
                  'Custom',
                  'assets/images/Screen_19_5.png',
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
              decoration: BoxDecoration(
                color: AppColors.searchBarFillColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe your event here...',
                  hintStyle: TextStyle(
                    color: AppColors.lightText,
                    fontSize: 14,
                  ),
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
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
              child: DropdownButtonFormField<String>(
                initialValue: selectedCategory,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Select Category',
                  hintStyle: TextStyle(color: AppColors.darkText, fontSize: 14),
                ),
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.darkText),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            // Upload Banner
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Upload dialogue opened (Feature simulation)')),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
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
    String imagePath, {
    bool isTextDark = false,
  }) {
    bool isSelected = selectedType == title;
    return GestureDetector(
      onTap: () => setState(() => selectedType = title),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: AppColors.primaryGreen, width: 2)
                    : Border.all(color: Colors.transparent, width: 2), // Keeps the layout stable
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Safe radius within the border
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.lightGreyBackground,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: isTextDark ? AppColors.darkText : AppColors.darkText, // Ensures text is always correct color
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
    // double dashWidth = 8, dashSpace = 4;
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
