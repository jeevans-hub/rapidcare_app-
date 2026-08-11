import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

class HealthArticleSearch extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const HealthArticleSearch({
    super.key,
    this.hintText = 'Search health articles...',
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.textSecondaryGrey),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.textSecondaryGrey),
          border: InputBorder.none,
          icon: const Icon(Icons.search, color: AppColors.textSecondaryGrey),
          suffixIcon: onClear != null
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.textSecondaryGrey),
                  onPressed: onClear,
                )
              : null,
        ),
      ),
    );
  }
}
