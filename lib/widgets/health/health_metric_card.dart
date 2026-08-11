import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthMetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? unit;
  final VoidCallback? onViewDetails;

  const HealthMetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.unit,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.backgroundLightGreyDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primaryBlue,
            size: 24,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyles.title.copyWith(
                  fontSize: 28,
                  color: AppColors.primaryBlue,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    unit!,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryGrey,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (onViewDetails != null) ...[
            const SizedBox(height: AppSpacing.sm),
            InkWell(
              onTap: onViewDetails,
              borderRadius: BorderRadius.circular(AppRadius.small),
              child: Text(
                'View Details',
                style: AppTextStyles.small.copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
