import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'notification_card.dart';
import 'notification_type_icon.dart';

class NotificationGroup extends StatelessWidget {
  final String title;
  final List<NotificationItem> notifications;

  const NotificationGroup({
    super.key,
    required this.title,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondaryGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...notifications.map((notification) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: NotificationCard(
              type: notification.type,
              title: notification.title,
              description: notification.description,
              time: notification.time,
              priority: notification.priority,
              isRead: notification.isRead,
              onTap: notification.onTap,
              onDelete: notification.onDelete,
            ),
          );
        }),
      ],
    );
  }
}

class NotificationItem {
  final NotificationType type;
  final String title;
  final String description;
  final String time;
  final String priority;
  final bool isRead;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  NotificationItem({
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    this.priority = 'normal',
    this.isRead = false,
    this.onTap,
    this.onDelete,
  });
}
