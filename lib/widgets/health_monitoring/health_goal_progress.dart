import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthGoalProgress extends StatelessWidget {
  final double progress;
  final String percentage;

  const HealthGoalProgress({
    super.key,
    required this.progress,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.textSecondaryGrey.withValues(alpha: 0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          percentage,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
