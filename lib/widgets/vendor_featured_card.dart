import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class VendorFeaturedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color imageColor;
  final String? imagepath; // Made optional to prevent errors when not provided

  const VendorFeaturedCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.imagepath,
    this.imageColor = AppColors.darkText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(12),
              image: imagepath != null
                  ? DecorationImage(
                      image: AssetImage(imagepath!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imagepath == null
                ? const Center(
                    child: Icon(Icons.storefront, color: Colors.white54, size: 40),
                  )
                : null,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: AppTextStyles.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
