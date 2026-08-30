import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class AmbulanceTrackerCard extends StatelessWidget {
  const AmbulanceTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.errorRed.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                  child: Icon(
                    Icons.local_taxi,
                    color: AppColors.errorRed,
                    size: 32,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ambulance Tracker',
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Live ambulance tracking is not connected in this demo.',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated Arrival',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Unavailable',
                      style: AppTextStyles.headline.copyWith(
                        color: AppColors.errorRed,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                  value: 0,
                    backgroundColor: AppColors.textSecondaryGreyLight,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.errorRed),
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
