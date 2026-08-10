import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class MedicalRecordSummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color? color;

  const MedicalRecordSummaryCard({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
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
        children: [
          Icon(
            icon,
            color: cardColor,
            size: 28,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            count.toString(),
            style: AppTextStyles.title.copyWith(
              color: cardColor,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: cardColor,
            ),
          ),
        ],
      ),
    );
  }
}
