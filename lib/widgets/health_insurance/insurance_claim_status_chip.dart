import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class InsuranceClaimStatusChip extends StatelessWidget {
  final String status;

  const InsuranceClaimStatusChip({
    super.key,
    required this.status,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.successGreen;
      case 'under review':
        return AppColors.warningOrange;
      case 'pending':
        return AppColors.primaryBlue;
      case 'rejected':
        return AppColors.errorRed;
      case 'active':
        return AppColors.successGreen;
      case 'expired':
        return AppColors.textSecondaryGrey;
      default:
        return AppColors.textSecondaryGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: AppTextStyles.small.copyWith(
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}
