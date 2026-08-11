import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthActivityCard extends StatelessWidget {
  final String activityName;
  final String value;
  final String unit;
  final IconData icon;
  final VoidCallback? onTap;

  const HealthActivityCard({
    super.key,
    required this.activityName,
    required this.value,
    required this.unit,
    required this.icon,
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
                size: 32,
                color: AppColors.secondaryTeal,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                activityName,
                style: AppTextStyles.title,
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Text(
                    value,
                    style: AppTextStyles.headline.copyWith(
                      color: AppColors.secondaryTeal,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    unit,
                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Demo',
                style: AppTextStyles.small.copyWith(
                  color: AppColors.warningOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
