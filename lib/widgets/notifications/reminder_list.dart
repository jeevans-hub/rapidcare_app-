import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'reminder_card.dart';

class ReminderList extends StatelessWidget {
  final List<ReminderItem> reminders;

  const ReminderList({
    super.key,
    required this.reminders,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reminders.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        return ReminderCard(
          icon: reminder.icon,
          title: reminder.title,
          description: reminder.description,
          dateTime: reminder.dateTime,
          status: reminder.status,
          isEnabled: reminder.isEnabled,
          onTap: reminder.onTap,
          onToggle: reminder.onToggle,
        );
      },
    );
  }
}

class ReminderItem {
  final IconData icon;
  final String title;
  final String description;
  final String dateTime;
  final ReminderStatus status;
  final bool isEnabled;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;

  ReminderItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.status,
    this.isEnabled = true,
    this.onTap,
    this.onToggle,
  });
}
