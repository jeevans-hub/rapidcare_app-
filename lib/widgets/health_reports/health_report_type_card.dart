import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthReportTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final int reportCount;
  final VoidCallback? onTap;

  const HealthReportTypeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.reportCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.large),
      splashColor: AppColors.primaryBlueLight.withValues(alpha: 0.3),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                title,
                style: AppTextStyles.title,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                description,
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryTeal.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Text(
                  '$reportCount Reports',
                  style: AppTextStyles.small,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
