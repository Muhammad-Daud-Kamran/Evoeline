import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Role selection toggle used in the Sign Up screen
class RoleSelectionToggle extends StatefulWidget {
  final Function(String) onRoleSelected;

  const RoleSelectionToggle({super.key, required this.onRoleSelected});

  @override
  State<RoleSelectionToggle> createState() => _RoleSelectionToggleState();
}

class _RoleSelectionToggleState extends State<RoleSelectionToggle> {
  String selectedRole = 'Attendee';
  final List<String> roles = ['Organizer', 'Attendee', 'Vendor'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: roles.map((role) {
          final isSelected = selectedRole == role;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedRole = role;
                });
                widget.onRoleSelected(role);
              },
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
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  role,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.darkText
                        : AppColors.lightText,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
