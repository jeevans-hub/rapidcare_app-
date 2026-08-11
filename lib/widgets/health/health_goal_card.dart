import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthGoalCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String current;
  final String target;
  final double progress;

  const HealthGoalCard({
    super.key,
    required this.icon,
    required this.title,
    required this.current,
    required this.target,
    required this.progress,
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
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.secondaryTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Icon(
                  icon,
                  color: AppColors.secondaryTeal,
                  size: 18,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Text(
                current,
                style: AppTextStyles.title.copyWith(
                  fontSize: 24,
                  color: AppColors.secondaryTeal,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '/ $target',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondaryGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.backgroundLightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1.0
                  ? AppColors.successGreen
                  : AppColors.secondaryTeal,
            ),
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
        ],
      ),
    );
  }
}
