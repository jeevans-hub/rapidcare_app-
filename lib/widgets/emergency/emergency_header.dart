import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class EmergencyHeader extends StatelessWidget {
  const EmergencyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.emergency,
          size: 48,
          color: AppColors.errorRed,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Emergency Assistance',
          style: AppTextStyles.headline,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Get immediate help during emergencies',
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
