import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';

class PharmacyOrderConfirmationScreen extends StatelessWidget {
  const PharmacyOrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.xl),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.successGreenLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 64,
                    color: AppColors.successGreen,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Order Confirmed',
                  style: AppTextStyles.headline.copyWith(
                    color: AppColors.successGreen,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Your medicine order has been placed successfully.',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondaryGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xl),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _OrderDetailRow(
                          label: 'Order ID',
                          value: '#RXD123456',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _OrderDetailRow(
                          label: 'Estimated Delivery',
                          value: 'Aug 15, 2026',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _OrderDetailRow(
                          label: 'Delivery Address',
                          value: '123 Main St, City',
                        ),
                        const Divider(height: AppSpacing.lg),
                        const Text(
                          'Ordered Medicines',
                          style: AppTextStyles.title,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _MedicineItem(name: 'Paracetamol 500mg', qty: 'x2'),
                        _MedicineItem(name: 'Vitamin C 1000mg', qty: 'x1'),
                        const Divider(height: AppSpacing.lg),
                        _OrderDetailRow(
                          label: 'Total Amount',
                          value: '\$27.96',
                          valueStyle: AppTextStyles.title.copyWith(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  text: 'Track Order',
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(AppRoutes.home),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(AppRoutes.home),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                    ),
                  ),
                  child: const Text('Back to Home'),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _OrderDetailRow({
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondaryGrey,
          ),
        ),
        Text(
          value,
          style: valueStyle ?? AppTextStyles.body,
        ),
      ],
    );
  }
}

class _MedicineItem extends StatelessWidget {
  final String name;
  final String qty;

  const _MedicineItem({
    required this.name,
    required this.qty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: AppTextStyles.body,
          ),
          Text(
            qty,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),
        ],
      ),
    );
  }
}
