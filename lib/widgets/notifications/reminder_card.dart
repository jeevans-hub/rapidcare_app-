import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'reminder_status_chip.dart';

class ReminderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String dateTime;
  final ReminderStatus status;
  final bool isEnabled;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;

  const ReminderCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.status,
    this.isEnabled = true,
    this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.surfaceWhite : AppColors.backgroundLightGrey,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(color: AppColors.backgroundLightGreyDark),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isEnabled
                    ? AppColors.primaryBlue.withValues(alpha: 0.1)
                    : AppColors.backgroundLightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isEnabled ? AppColors.primaryBlue : AppColors.textSecondaryGrey,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isEnabled ? null : AppColors.textSecondaryGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateTime,
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            ReminderStatusChip(status: status),
            const SizedBox(width: AppSpacing.sm),
            Switch(
              value: isEnabled,
              onChanged: onToggle != null ? (value) => onToggle!() : null,
              activeThumbColor: AppColors.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}

enum ReminderStatus {
  active,
  paused,
  completed,
}
