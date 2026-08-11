import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthMetricCard extends StatelessWidget {
  final IconData icon;
  final String metricName;
  final String value;
  final String unit;
  final String status;
  final String lastUpdated;
  final VoidCallback? onTap;

  const HealthMetricCard({
    super.key,
    required this.icon,
    required this.metricName,
    required this.value,
    required this.unit,
    required this.status,
    required this.lastUpdated,
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
              Row(
                children: [
                  Icon(
                    icon,
                    size: 32,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      metricName,
                      style: AppTextStyles.title,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Text(
                    value,
                    style: AppTextStyles.headline.copyWith(
                      color: AppColors.primaryBlue,
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Text(
                  status,
                  style: AppTextStyles.small,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                lastUpdated,
                style: AppTextStyles.small,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: onTap,
                child: const Text('View Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
