import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class DoctorSpecialtyCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String description;
  final int doctorCount;
  final VoidCallback? onTap;

  const DoctorSpecialtyCard({
    super.key,
    required this.icon,
    required this.name,
    required this.description,
    required this.doctorCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(color: AppColors.backgroundLightGreyDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.small),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryBlue,
                size: 24,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              name,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              description,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondaryGrey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 14,
                  color: AppColors.textSecondaryGrey,
                ),
                const SizedBox(width: 4),
                Text(
                  '$doctorCount Doctors',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
