import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthReportsHeader extends StatelessWidget {
  const HealthReportsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.assessment,
          size: 48,
          color: AppColors.primaryBlue,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Health Reports',
          style: AppTextStyles.headline,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'View your health reports and analytics',
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
