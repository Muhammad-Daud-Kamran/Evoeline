import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A common bottom navigation bar shown across screens
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({Key? key, required this.currentIndex})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.darkText,
      unselectedItemColor: AppColors.lightText,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 8,
      backgroundColor: AppColors.background,
      onTap: (_) {}, // Handled by standard navigation
      items: [
        // TODO: To replace these default Icons with your custom PNG/SVG Images from assets:
        // Change `icon: Icon(Icons.home_outlined)` to:
        // `icon: Image.asset('assets/images/home_icon.png', width: 24, height: 24)`
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.darkText,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 20),
          ),
          label: 'Add',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_num_outlined),
          label: 'Ticket',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
