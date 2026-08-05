import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';

class TimeSlotCard extends StatelessWidget {
  final String time;
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback? onTap;

  const TimeSlotCard({
    super.key,
    required this.time,
    this.isSelected = false,
    this.isAvailable = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryBlue
              : isAvailable
                  ? AppColors.surfaceWhite
                  : AppColors.backgroundLightGrey,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryBlue
                : isAvailable
                    ? AppColors.backgroundLightGreyDark
                    : AppColors.backgroundLightGrey,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 12,
            color: isSelected
                ? Colors.white
                : isAvailable
                    ? AppColors.textPrimaryDarkGrey
                    : AppColors.textSecondaryGrey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
