import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum NotificationType {
  appointment,
  medicine,
  health,
  pharmacy,
  emergency,
  general,
}

class NotificationTypeIcon extends StatelessWidget {
  final NotificationType type;

  const NotificationTypeIcon({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (type) {
      case NotificationType.appointment:
        icon = Icons.calendar_today;
        color = AppColors.primaryBlue;
        break;
      case NotificationType.medicine:
        icon = Icons.medication;
        color = AppColors.secondaryTeal;
        break;
      case NotificationType.health:
        icon = Icons.favorite;
        color = AppColors.errorRed;
        break;
      case NotificationType.pharmacy:
        icon = Icons.local_pharmacy;
        color = AppColors.warningOrange;
        break;
      case NotificationType.emergency:
        icon = Icons.emergency;
        color = AppColors.errorRed;
        break;
      case NotificationType.general:
        icon = Icons.notifications;
        color = AppColors.primaryBlue;
        break;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }
}
