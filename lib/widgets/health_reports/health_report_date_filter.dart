import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HealthReportDateFilter extends StatelessWidget {
  final String selectedPeriod;
  final ValueChanged<String> onPeriodChanged;

  const HealthReportDateFilter({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final periods = ['This Week', 'Last Week', 'This Month', 'Last Month'];

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
              'Time Period',
              style: AppTextStyles.subtitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: periods.map((period) {
                final isSelected = selectedPeriod == period;
                return FilterChip(
                  label: Text(
                    period,
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected ? AppColors.white : AppColors.textPrimaryDarkGrey,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      onPeriodChanged(period);
                    }
                  },
                  selectedColor: AppColors.primaryBlue,
                  backgroundColor: AppColors.surfaceWhite,
                  checkmarkColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  side: BorderSide(
                    color: isSelected ? AppColors.primaryBlue : AppColors.textSecondaryGrey,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
