import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';

class VendorPopularListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color badgeColor;
  final String? imagepath;


  const VendorPopularListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.badgeColor,
    this.imagepath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verified',
                  style: AppTextStyles.label.copyWith(
                    color: Colors.blueAccent,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTextStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.label),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 60,
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(8),
              image: imagepath != null
                  ? DecorationImage(
                      image: AssetImage(imagepath!),
                      fit: BoxFit.cover,
                    )
                  : null,


            ),
          ),
        ],
      ),
    );
  }
}
