import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class NearbyHospitalCard extends StatelessWidget {
  final String name;
  final String distance;
  final String estimatedArrival;
  final VoidCallback? onNavigate;

  const NearbyHospitalCard({
    super.key,
    required this.name,
    required this.distance,
    required this.estimatedArrival,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.primaryBlueLight.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppRadius.medium),
              ),
              child: Icon(
                Icons.local_hospital,
                color: AppColors.primaryBlue,
                size: 32,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.title,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.textSecondaryGrey,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        distance,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.textSecondaryGrey,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        estimatedArrival,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
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
                'Open Now',
                style: AppTextStyles.small.copyWith(
                  color: AppColors.successGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              icon: const Icon(Icons.navigation),
              color: AppColors.primaryBlue,
              onPressed: onNavigate,
            ),
          ],
        ),
      ),
    );
  }
}
