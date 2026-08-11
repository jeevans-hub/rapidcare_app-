import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class InsuranceBenefitsCard extends StatelessWidget {
  final String title;
  final List<String> benefits;

  const InsuranceBenefitsCard({
    super.key,
    required this.title,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppColors.successGreen,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  title,
                  style: AppTextStyles.subtitle,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...benefits.map((benefit) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: AppTextStyles.caption,
                      ),
                      Expanded(
                        child: Text(
                          benefit,
                          style: AppTextStyles.caption,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
