import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthProgressCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final double progress;
  final Color? color;

  const HealthProgressCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.progress,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.primaryBlue;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cardColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(
          color: cardColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Text(
                value,
                style: AppTextStyles.title.copyWith(
                  fontSize: 28,
                  color: cardColor,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: AppColors.backgroundLightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(cardColor),
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
        ],
      ),
    );
  }
}
