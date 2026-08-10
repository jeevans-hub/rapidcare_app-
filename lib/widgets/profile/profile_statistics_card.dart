import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class ProfileStatisticsCard extends StatelessWidget {
  final int appointments;
  final int prescriptions;
  final int healthRecords;

  const ProfileStatisticsCard({
    super.key,
    required this.appointments,
    required this.prescriptions,
    required this.healthRecords,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(
            icon: Icons.calendar_today,
            label: 'Appointments',
            value: appointments.toString(),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatItem(
            icon: Icons.medication,
            label: 'Prescriptions',
            value: prescriptions.toString(),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatItem(
            icon: Icons.folder_open,
            label: 'Records',
            value: healthRecords.toString(),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
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
        children: [
          Icon(
            icon,
            color: AppColors.primaryBlue,
            size: 24,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTextStyles.title.copyWith(
              color: AppColors.primaryBlue,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.small,
          ),
        ],
      ),
    );
  }
}
