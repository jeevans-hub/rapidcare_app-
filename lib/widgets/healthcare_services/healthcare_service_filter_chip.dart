import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_text_styles.dart';

class HealthcareServiceFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  const HealthcareServiceFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: isSelected ? AppColors.white : AppColors.textPrimaryDarkGrey,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: AppColors.primaryBlue,
      backgroundColor: AppColors.surfaceWhite,
      checkmarkColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primaryBlue : AppColors.textSecondaryGrey,
      ),
    );
  }
}
