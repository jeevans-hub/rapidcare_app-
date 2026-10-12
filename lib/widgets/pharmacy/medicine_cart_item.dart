import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'medicine_quantity_selector.dart';

class MedicineCartItem extends StatelessWidget {
  final String name;
  final double price;
  final int quantity;
  final ValueChanged<int>? onQuantityChanged;
  final VoidCallback? onRemove;

  const MedicineCartItem({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    this.onQuantityChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.textScalerOf(context).scale(16) > 24
                      ? 36
                      : 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLightGrey,
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                  child: const Icon(
                    Icons.medication,
                    size: 32,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.title.copyWith(fontSize: 16),
                        softWrap: true,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                  color: AppColors.errorRed,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MedicineQuantitySelector(
                initialQuantity: quantity,
                onQuantityChanged: onQuantityChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
