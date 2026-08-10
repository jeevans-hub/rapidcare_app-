import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class PrescriptionRecordCard extends StatelessWidget {
  final String medicineName;
  final String doctor;
  final String hospital;
  final String date;
  final String dosage;
  final String duration;
  final String status;

  const PrescriptionRecordCard({
    super.key,
    required this.medicineName,
    required this.doctor,
    required this.hospital,
    required this.date,
    required this.dosage,
    required this.duration,
    required this.status,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondaryTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
                child: Icon(
                  Icons.medication,
                  color: AppColors.secondaryTeal,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicineName,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      doctor,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Text(
                  status,
                  style: AppTextStyles.small.copyWith(
                    color: _getStatusColor(status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(label: 'Hospital', value: hospital),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Date', value: date),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Dosage', value: dosage),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Duration', value: duration),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.successGreen;
      case 'completed':
        return AppColors.textSecondaryGrey;
      default:
        return AppColors.warningOrange;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.body,
          ),
        ),
      ],
    );
  }
}
