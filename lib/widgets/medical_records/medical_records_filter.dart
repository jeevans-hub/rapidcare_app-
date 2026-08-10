import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'medical_record_type_chip.dart';

class MedicalRecordsFilter extends StatefulWidget {
  final String selectedFilter;
  final ValueChanged<String>? onFilterChanged;

  const MedicalRecordsFilter({
    super.key,
    required this.selectedFilter,
    this.onFilterChanged,
  });

  @override
  State<MedicalRecordsFilter> createState() => _MedicalRecordsFilterState();
}

class _MedicalRecordsFilterState extends State<MedicalRecordsFilter> {
  final List<String> _filters = [
    'All',
    'Prescriptions',
    'Lab Reports',
    'Doctor Reports',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: _filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: MedicalRecordTypeChip(
              label: filter,
              isSelected: widget.selectedFilter == filter,
              onTap: () {
                widget.onFilterChanged?.call(filter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
