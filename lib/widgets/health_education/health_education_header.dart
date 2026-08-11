import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthEducationHeader extends StatelessWidget {
  const HealthEducationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.school,
          size: 48,
          color: AppColors.primaryBlue,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Health Education',
          style: AppTextStyles.headline,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Educational resources for a healthier lifestyle',
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
