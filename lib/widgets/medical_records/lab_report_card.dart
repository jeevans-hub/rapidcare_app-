import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class LabReportCard extends StatelessWidget {
  final String testName;
  final String hospitalOrLab;
  final String date;
  final String status;

  const LabReportCard({
    super.key,
    required this.testName,
    required this.hospitalOrLab,
    required this.date,
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
                  color: AppColors.warningOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
                child: Icon(
                  Icons.biotech,
                  color: AppColors.warningOrange,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testName,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      hospitalOrLab,
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
          _InfoRow(label: 'Date', value: date),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
        return AppColors.successGreen;
      case 'abnormal':
        return AppColors.errorRed;
      case 'pending':
        return AppColors.warningOrange;
      default:
        return AppColors.textSecondaryGrey;
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
