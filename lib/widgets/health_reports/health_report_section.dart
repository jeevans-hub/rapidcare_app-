import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthReportSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const HealthReportSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(AppRadius.small),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              title,
              style: AppTextStyles.title,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...children,
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
