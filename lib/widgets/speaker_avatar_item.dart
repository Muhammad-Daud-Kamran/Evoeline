import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class SpeakerAvatarItem extends StatelessWidget {
  final String name;
  final String role;
  final Color avatarColor;
  final String imagepath;

  const SpeakerAvatarItem({
    Key? key,
    required this.name,
    required this.role,
    required this.imagepath,
    this.avatarColor = AppColors.primaryGreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: avatarColor,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imagepath),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            role,
            style: AppTextStyles.label.copyWith(fontSize: 11),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
