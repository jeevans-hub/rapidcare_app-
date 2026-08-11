import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthSummaryCard extends StatelessWidget {
  final Map<String, String> summary;

  const HealthSummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.today,
                  size: 32,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Today\'s Health Summary',
                  style: AppTextStyles.title,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ...summary.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Text(
                    '${entry.key}: ',
                    style: AppTextStyles.caption,
                  ),
                  Text(
                    entry.value,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Demo',
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.warningOrange,
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
