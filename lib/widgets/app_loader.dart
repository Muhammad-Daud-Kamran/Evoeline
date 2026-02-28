import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A standard global application loader
class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
      ),
    );
  }
}
