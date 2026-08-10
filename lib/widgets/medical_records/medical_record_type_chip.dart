import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class MedicalRecordTypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const MedicalRecordTypeChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: AppTextStyles.small.copyWith(
          color: isSelected ? AppColors.white : AppColors.textSecondaryGrey,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) => onTap?.call(),
      selectedColor: AppColors.primaryBlue,
      backgroundColor: AppColors.surfaceWhite,
      checkmarkColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
        side: BorderSide(
          color: isSelected ? AppColors.primaryBlue : AppColors.backgroundLightGreyDark,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
    );
  }
}
