import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';

class DoctorReportCard extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String hospital;
  final String visitDate;
  final String diagnosis;
  final String followUp;
  final VoidCallback? onViewDetails;

  const DoctorReportCard({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.hospital,
    required this.visitDate,
    required this.diagnosis,
    required this.followUp,
    this.onViewDetails,
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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_hospital,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      specialization,
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(label: 'Hospital', value: hospital),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Visit Date', value: visitDate),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Diagnosis', value: diagnosis),
          const SizedBox(height: AppSpacing.sm),
          _InfoRow(label: 'Follow-up', value: followUp),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            text: 'View Details',
            onPressed: onViewDetails,
          ),
        ],
      ),
    );
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
          width: 80,
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
