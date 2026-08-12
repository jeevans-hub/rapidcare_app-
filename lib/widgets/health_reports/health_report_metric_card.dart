import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthReportMetricCard extends StatelessWidget {
  final String metricName;
  final String value;
  final String unit;
  final String date;
  final IconData icon;
  final String status;

  const HealthReportMetricCard({
    super.key,
    required this.metricName,
    required this.value,
    required this.unit,
    required this.date,
    required this.icon,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metricName,
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: AppSpacing.xs),
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
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: AppTextStyles.small,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
