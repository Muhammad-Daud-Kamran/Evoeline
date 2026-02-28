import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Mockups for the line and bar charts in the Analytics screen
class RegistrationLineChartMockup extends StatelessWidget {
  const RegistrationLineChartMockup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: CustomPaint(painter: _LineChartPainter()),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryGreen
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.2,
      size.width * 0.2,
      size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.8,
      size.width * 0.4,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      size.width * 0.6,
      size.height * 0.9,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.1,
      size.width * 0.8,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.8,
      size.width,
      size.height * 0.3,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CheckInBarChartMockup extends StatelessWidget {
  const CheckInBarChartMockup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heights = [0.4, 0.6, 1.0, 0.5, 0.7, 0.3, 0.8];
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: heights.map((h) {
          return Container(
            width: 24,
            height: 100 * h,
            decoration: const BoxDecoration(
              color: AppColors.analyticsLightGreen,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(height: 2, color: AppColors.primaryGreen),
            ),
          );
        }).toList(),
      ),
    );
  }
}
