import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'doctor_specialty_card.dart';

class DoctorSpecialtiesGrid extends StatelessWidget {
  final List<SpecialtyItem> specialties;

  const DoctorSpecialtiesGrid({
    super.key,
    required this.specialties,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.2,
          children: specialties.map((specialty) {
            return DoctorSpecialtyCard(
              icon: specialty.icon,
              name: specialty.name,
              description: specialty.description,
              doctorCount: specialty.doctorCount,
              onTap: specialty.onTap,
            );
          }).toList(),
        );
      },
    );
  }
}

class SpecialtyItem {
  final IconData icon;
  final String name;
  final String description;
  final int doctorCount;
  final VoidCallback? onTap;

  SpecialtyItem({
    required this.icon,
    required this.name,
    required this.description,
    required this.doctorCount,
    this.onTap,
  });
}
