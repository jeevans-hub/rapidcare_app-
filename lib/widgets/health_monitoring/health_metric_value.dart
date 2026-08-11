import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthMetricValue extends StatelessWidget {
  final String value;
  final String unit;
  final Color? valueColor;

  const HealthMetricValue({
    super.key,
    required this.value,
    required this.unit,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTextStyles.headline.copyWith(
            color: valueColor ?? AppColors.primaryBlue,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          unit,
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }
}
