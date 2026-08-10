import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class PharmacyOrderStatusCard extends StatelessWidget {
  final String orderId;
  final String status;
  final String estimatedDelivery;
  final int currentStep;

  const PharmacyOrderStatusCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.estimatedDelivery,
    this.currentStep = 1,
  });

  @override
  Widget build(BuildContext context) {
    final steps = ['Order Placed', 'Preparing', 'Out for Delivery', 'Delivered'];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #$orderId',
                  style: AppTextStyles.title,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.circular(AppRadius.small),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Estimated: $estimatedDelivery',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            ...List.generate(steps.length, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep - 1;

              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? AppColors.successGreen
                              : AppColors.backgroundLightGreyDark,
                          shape: BoxShape.circle,
                        ),
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: AppColors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        steps[index],
                        style: AppTextStyles.body.copyWith(
                          color: isCompleted
                              ? AppColors.successGreen
                              : AppColors.textSecondaryGrey,
                          fontWeight:
                              isCurrent ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  if (index < steps.length - 1)
                    Padding(
                      padding: const EdgeInsets.only(left: 11),
                      child: Container(
                        height: 24,
                        width: 2,
                        color: isCompleted
                            ? AppColors.successGreen
                            : AppColors.backgroundLightGreyDark,
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'order placed':
        return AppColors.primaryBlue;
      case 'preparing':
        return AppColors.warningOrange;
      case 'out for delivery':
        return AppColors.secondaryTeal;
      case 'delivered':
        return AppColors.successGreen;
      default:
        return AppColors.textSecondaryGrey;
    }
  }
}
