import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';

class ReminderDetailsScreen extends StatelessWidget {
  const ReminderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? reminder =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final title = reminder?['title']?.toString() ?? 'Doctor Appointment';
    final description = reminder?['description']?.toString() ?? 'Dr. Sarah Johnson';
    final category = reminder?['category']?.toString() ?? 'Appointment';
    final date = reminder?['date']?.toString() ?? 'Aug 12, 2026';
    final time = reminder?['time']?.toString() ?? '10:00 AM';
    final repeat = reminder?['repeat']?.toString() ?? 'Once';
    final status = reminder?['status']?.toString() ?? 'Active';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    color: AppColors.primaryBlue,
                    size: 32,
                  ),
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
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                _InfoSection(
                  icon: Icons.category,
                  label: 'Category',
                  value: category,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoSection(
                  icon: Icons.calendar_today,
                  label: 'Date',
                  value: date,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoSection(
                  icon: Icons.access_time,
                  label: 'Time',
                  value: time,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoSection(
                  icon: Icons.repeat,
                  label: 'Repeat',
                  value: repeat,
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoSection(
                  icon: Icons.check_circle,
                  label: 'Status',
                  value: status,
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: 'Edit Reminder',
                        onPressed: () {},
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

class _InfoSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoSection({
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
