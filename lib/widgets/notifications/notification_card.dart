import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'notification_type_icon.dart';

class NotificationCard extends StatelessWidget {
  final NotificationType type;
  final String title;
  final String description;
  final String time;
  final String priority;
  final bool isRead;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const NotificationCard({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    this.priority = 'normal',
    this.isRead = false,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isRead ? AppColors.surfaceWhite : AppColors.primaryBlue.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(
            color: isRead ? AppColors.backgroundLightGreyDark : AppColors.primaryBlue.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            NotificationTypeIcon(type: type),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryGrey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.textSecondaryGrey,
                    ),
                  ),
                  Text(
                    'Priority: $priority',
                    style: AppTextStyles.small.copyWith(
                      color: priority == 'high'
                          ? AppColors.errorRed
                          : AppColors.textSecondaryGrey,
                    ),
                  ),
                ],
              ),
            ),
            if (onDelete != null)
              IconButton(icon: const Icon(Icons.delete_outline), onPressed: onDelete),
            if (!isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
