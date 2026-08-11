import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class ExerciseTrackerCard extends StatelessWidget {
  final String duration;
  final String targetDuration;
  final String activity;

  const ExerciseTrackerCard({
    super.key,
    required this.duration,
    required this.targetDuration,
    required this.activity,
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
              Icon(
                Icons.fitness_center,
                color: AppColors.warningOrange,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Exercise',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Text(
                duration,
                style: AppTextStyles.title.copyWith(
                  fontSize: 32,
                  color: AppColors.warningOrange,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '/ $targetDuration',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Text(
                'Activity: ',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondaryGrey,
                ),
              ),
              Text(
                activity,
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
