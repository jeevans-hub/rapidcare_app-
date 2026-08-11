import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'insurance_filter_chip.dart';

class InsuranceFilters extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String>? onFilterChanged;

  const InsuranceFilters({
    super.key,
    required this.filters,
    required this.selectedFilter,
    this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: InsuranceFilterChip(
              label: filter,
              isSelected: selectedFilter == filter,
              onSelected: (selected) {
                if (selected) {
                  onFilterChanged?.call(filter);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
