import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthMonitoringHeader extends StatelessWidget {
  const HealthMonitoringHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.monitor_heart,
          size: 48,
          color: AppColors.primaryBlue,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Health Monitoring',
          style: AppTextStyles.headline,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Track your health metrics and activity',
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
