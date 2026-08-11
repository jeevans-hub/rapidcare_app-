import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class DoctorAvailabilityCard extends StatelessWidget {
  final List<String> todaySlots;
  final List<String> tomorrowSlots;

  const DoctorAvailabilityCard({
    super.key,
    required this.todaySlots,
    required this.tomorrowSlots,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.backgroundLightGreyDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: AppColors.primaryBlue,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Available Timings',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _DaySection(
            day: 'Today',
            slots: todaySlots,
            color: AppColors.successGreen,
          ),
          const SizedBox(height: AppSpacing.md),
          _DaySection(
            day: 'Tomorrow',
            slots: tomorrowSlots,
            color: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}

class _DaySection extends StatelessWidget {
  final String day;
  final List<String> slots;
  final Color color;

  const _DaySection({
    required this.day,
    required this.slots,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondaryGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: slots.map((slot) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.small),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Text(
                slot,
                style: AppTextStyles.small.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
