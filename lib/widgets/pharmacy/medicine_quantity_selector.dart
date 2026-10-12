import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

class MedicineQuantitySelector extends StatelessWidget {
  final int initialQuantity;
  final ValueChanged<int>? onQuantityChanged;
  const MedicineQuantitySelector({
    super.key,
    this.initialQuantity = 1,
    this.onQuantityChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.textSecondaryGreyLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: initialQuantity > 1
                ? () => onQuantityChanged?.call(initialQuantity - 1)
                : null,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.medium),
              bottomLeft: Radius.circular(AppRadius.medium),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: const Icon(Icons.remove, size: 20),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              child: Text(
                '$initialQuantity',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => onQuantityChanged?.call(initialQuantity + 1),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(AppRadius.medium),
              bottomRight: Radius.circular(AppRadius.medium),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: const Icon(Icons.add, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
