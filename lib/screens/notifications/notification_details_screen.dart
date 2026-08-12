import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/notifications/notification_widgets.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? notification =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final title = notification?['title']?.toString() ?? 'Appointment Reminder';
    final description = notification?['description']?.toString() ?? 'Your appointment details';
    final category = notification?['category']?.toString() ?? 'Appointment';
    final date = notification?['date']?.toString() ?? 'Aug 12, 2026';
    final time = notification?['time']?.toString() ?? '10:00 AM';
    final type = notification?['type'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationTypeIcon(
                  type: type == 'medicine'
                      ? NotificationType.medicine
                      : type == 'health'
                          ? NotificationType.health
                          : type == 'pharmacy'
                              ? NotificationType.pharmacy
                              : type == 'emergency'
                                  ? NotificationType.emergency
                                  : NotificationType.appointment,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title,
                  style: AppTextStyles.title,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  description,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondaryGrey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _InfoRow(
                  icon: Icons.category,
                  label: 'Category',
                  value: category,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoRow(
                  icon: Icons.calendar_today,
                  label: 'Date',
                  value: date,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoRow(
                  icon: Icons.access_time,
                  label: 'Time',
                  value: time,
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.medium),
                          ),
                        ),
                        child: const Text('Mark as Read'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.medium),
                          ),
                          side: const BorderSide(color: AppColors.errorRed),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: AppColors.errorRed),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryBlue,
          size: 20,
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          '$label:',
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondaryGrey,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          value,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
