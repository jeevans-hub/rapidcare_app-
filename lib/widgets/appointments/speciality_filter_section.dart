import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'doctor_speciality_chip.dart';

class SpecialityFilterSection extends StatefulWidget {
  final ValueChanged<String>? onSpecialtySelected;
  final List<String> specialties;

  const SpecialityFilterSection({
    super.key,
    this.onSpecialtySelected,
    this.specialties = const ['All'],
  });

  @override
  State<SpecialityFilterSection> createState() =>
      _SpecialityFilterSectionState();
}

class _SpecialityFilterSectionState extends State<SpecialityFilterSection> {
  String selectedSpecialty = 'All';

  @override
  Widget build(BuildContext context) {
    final specialties = widget.specialties;
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index < specialties.length - 1 ? AppSpacing.sm : 0,
            ),
            child: DoctorSpecialityChip(
              label: specialty,
              isSelected: selectedSpecialty == specialty,
              onTap: () {
                setState(() {
                  selectedSpecialty = specialty;
                });
                widget.onSpecialtySelected?.call(specialty);
              },
            ),
          );
        },
      ),
    );
  }
}
