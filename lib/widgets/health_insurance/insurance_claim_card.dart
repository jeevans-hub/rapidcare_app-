import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'insurance_claim_status_chip.dart';

class InsuranceClaimCard extends StatelessWidget {
  final String claimTitle;
  final String claimId;
  final String amount;
  final String date;
  final String status;
  final VoidCallback? onTap;

  const InsuranceClaimCard({
    super.key,
    required this.claimTitle,
    required this.claimId,
    required this.amount,
    required this.date,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.large),
      splashColor: AppColors.primaryBlueLight.withValues(alpha: 0.3),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 24,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      claimTitle,
                      style: AppTextStyles.title,
                    ),
                  ),
                  InsuranceClaimStatusChip(status: status),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Claim ID: $claimId',
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Text(
                    'Amount: ',
                    style: AppTextStyles.caption,
                  ),
                  Text(
                    amount,
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    date,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: onTap,
                child: const Text('View Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
