import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class MedicalRecordsHeader extends StatelessWidget {
  final String subtitle;

  const MedicalRecordsHeader({
    super.key,
    this.subtitle = 'Keep all your health information organized',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Medical Records',
          style: AppTextStyles.headline.copyWith(
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          subtitle,
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondaryGrey,
          ),
        ),
      ],
    );
  }
}
