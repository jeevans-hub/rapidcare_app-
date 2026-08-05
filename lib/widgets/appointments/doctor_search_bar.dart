import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';

class DoctorSearchBar extends StatelessWidget {
  const DoctorSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(color: AppColors.backgroundLightGreyDark),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search doctors by name or specialization',
          hintStyle: const TextStyle(
            color: AppColors.textSecondaryGrey,
          ),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.filter_list),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
        ),
      ),
    );
  }
}
