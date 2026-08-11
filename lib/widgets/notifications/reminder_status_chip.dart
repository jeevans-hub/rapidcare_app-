import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'reminder_card.dart';

class ReminderStatusChip extends StatelessWidget {
  final ReminderStatus status;

  const ReminderStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    String label;
    Color color;

    switch (status) {
      case ReminderStatus.active:
        label = 'Active';
        color = AppColors.successGreen;
        break;
      case ReminderStatus.paused:
        label = 'Paused';
        color = AppColors.warningOrange;
        break;
      case ReminderStatus.completed:
        label = 'Done';
        color = AppColors.primaryBlue;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Text(
        label,
        style: AppTextStyles.small.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
