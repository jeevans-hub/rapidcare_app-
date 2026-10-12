import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

class MedicineSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onChanged;

  const MedicineSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search medicines, health products...',
    this.onFilterTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(color: AppColors.textSecondaryGreyLight),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.textSecondaryGrey),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textSecondaryGrey,
          ),
          suffixIcon: IconButton(
            tooltip: 'Toggle in-stock filter',
            onPressed: onFilterTap,
            icon: const Icon(Icons.filter_list, color: AppColors.primaryBlue),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
      ),
    );
  }
}
