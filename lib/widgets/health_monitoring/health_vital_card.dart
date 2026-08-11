import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthVitalCard extends StatelessWidget {
  final String vitalName;
  final String value;
  final String unit;
  final IconData icon;
  final VoidCallback? onTap;

  const HealthVitalCard({
    super.key,
    required this.vitalName,
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
                color: AppColors.primaryBlue,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                vitalName,
                style: AppTextStyles.title,
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
              Text(
                'Demo',
                style: AppTextStyles.small.copyWith(
                  color: AppColors.warningOrange,
                ),
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
