import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthInsuranceHeader extends StatelessWidget {
  const HealthInsuranceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.shield,
          size: 48,
          color: AppColors.primaryBlue,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Health Insurance',
          style: AppTextStyles.headline,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Protect your health with comprehensive insurance plans',
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
