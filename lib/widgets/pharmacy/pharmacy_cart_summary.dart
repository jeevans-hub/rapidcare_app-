import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';

class PharmacyCartSummary extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final VoidCallback? onProceedToCheckout;

  const PharmacyCartSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    this.onProceedToCheckout,
  });

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Order Summary',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: AppSpacing.md),
            _SummaryRow(
              label: 'Subtotal',
              value: '\$${subtotal.toStringAsFixed(2)}',
            ),
            const SizedBox(height: AppSpacing.sm),
            _SummaryRow(
              label: 'Delivery Fee',
              value: '\$${deliveryFee.toStringAsFixed(2)}',
            ),
            if (discount > 0) ...[
              const SizedBox(height: AppSpacing.sm),
              _SummaryRow(
                label: 'Discount',
                value: '-\$${discount.toStringAsFixed(2)}',
                valueColor: AppColors.successGreen,
              ),
            ],
            const Divider(height: AppSpacing.lg),
            _SummaryRow(
              label: 'Total',
              value: '\$${total.toStringAsFixed(2)}',
              valueStyle: AppTextStyles.title.copyWith(
                color: AppColors.primaryBlue,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              text: 'Proceed to Checkout',
              onPressed: onProceedToCheckout,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueStyle,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text(
        label,
        style: AppTextStyles.body,
      ),
      Text(
        value,
        style: valueStyle ??
            AppTextStyles.body.copyWith(
              color: valueColor ?? AppColors.textPrimaryDarkGrey,
            ),
      ),
    ],
    );
  }
}
