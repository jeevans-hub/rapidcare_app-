import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

class MedicineQuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int>? onQuantityChanged;

  const MedicineQuantitySelector({
    super.key,
    this.initialQuantity = 1,
    this.onQuantityChanged,
  });

  @override
  State<MedicineQuantitySelector> createState() =>
      _MedicineQuantitySelectorState();
}

class _MedicineQuantitySelectorState extends State<MedicineQuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _increment() {
    setState(() {
      _quantity++;
      widget.onQuantityChanged?.call(_quantity);
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        widget.onQuantityChanged?.call(_quantity);
      });
    }
  }

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
            onTap: _decrement,
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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Text(
              '$_quantity',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          InkWell(
            onTap: _increment,
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
