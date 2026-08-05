import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'doctor_speciality_chip.dart';

class SpecialityFilterSection extends StatelessWidget {
  const SpecialityFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          DoctorSpecialityChip(label: 'All', isSelected: true),
          SizedBox(width: AppSpacing.sm),
          DoctorSpecialityChip(label: 'Cardiologist'),
          SizedBox(width: AppSpacing.sm),
          DoctorSpecialityChip(label: 'Dermatologist'),
          SizedBox(width: AppSpacing.sm),
          DoctorSpecialityChip(label: 'Orthopedic'),
          SizedBox(width: AppSpacing.sm),
          DoctorSpecialityChip(label: 'Neurologist'),
          SizedBox(width: AppSpacing.sm),
          DoctorSpecialityChip(label: 'Pediatrician'),
          SizedBox(width: AppSpacing.sm),
          DoctorSpecialityChip(label: 'General'),
        ],
      ),
    );
  }
}
