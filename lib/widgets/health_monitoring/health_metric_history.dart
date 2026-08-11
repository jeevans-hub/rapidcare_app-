import 'package:flutter/material.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthMetricHistory extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  const HealthMetricHistory({
    super.key,
    required this.history,
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
            Text(
              'History',
              style: AppTextStyles.subtitle,
            ),
            const SizedBox(height: AppSpacing.md),
            ...history.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry['date'] as String,
                      style: AppTextStyles.caption,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      entry['value'] as String,
                      style: AppTextStyles.body,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      entry['unit'] as String,
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
