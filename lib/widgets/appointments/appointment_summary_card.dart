import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';
import '../../widgets/section_title.dart';

class AppointmentSummaryCard extends StatelessWidget {
  const AppointmentSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Appointment Summary'),
          const SizedBox(height: AppSpacing.md),
          _SummaryRow(label: 'Doctor', value: 'Dr. Sarah Johnson'),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(label: 'Date', value: 'Mon, 15 Jan 2026'),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(label: 'Time', value: '09:00 AM'),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(label: 'Consultation', value: 'Video Consultation'),
          const SizedBox(height: AppSpacing.sm),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: 'Consultation Fee',
            value: '₹600',
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryGrey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? AppColors.primaryBlue : AppColors.textPrimaryDarkGrey,
          ),
        ),
      ],
    );
  }
}
