import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class MedicalRecordCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String doctorOrHospital;
  final String date;
  final String type;
  final VoidCallback? onTap;

  const MedicalRecordCard({
    super.key,
    required this.icon,
    required this.title,
    required this.doctorOrHospital,
    required this.date,
    required this.type,
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
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.medium),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doctorOrHospital,
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.textSecondaryGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _getTypeColor(type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.small),
              ),
              child: Text(
                type,
                style: AppTextStyles.small.copyWith(
                  color: _getTypeColor(type),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondaryGrey,
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'prescription':
        return AppColors.secondaryTeal;
      case 'lab report':
        return AppColors.warningOrange;
      case 'doctor report':
        return AppColors.primaryBlue;
      default:
        return AppColors.textSecondaryGrey;
    }
  }
}
