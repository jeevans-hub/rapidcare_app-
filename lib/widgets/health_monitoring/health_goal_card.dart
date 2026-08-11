import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthGoalCard extends StatelessWidget {
  final String goalName;
  final String current;
  final String target;
  final double progress;
  final String status;
  final IconData icon;

  const HealthGoalCard({
    super.key,
    required this.goalName,
    required this.current,
    required this.target,
    required this.progress,
    required this.status,
    required this.icon,
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
                    goalName,
                    style: AppTextStyles.title,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Text(
                  current,
                  style: AppTextStyles.headline.copyWith(
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '/ $target',
                  style: AppTextStyles.subtitle,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.textSecondaryGrey.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Text(
                  '${(progress * 100).toInt()}%',
                  style: AppTextStyles.caption,
                ),
                const Spacer(),
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
