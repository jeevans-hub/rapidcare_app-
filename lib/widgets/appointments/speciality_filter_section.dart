import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'doctor_speciality_chip.dart';

class SpecialityFilterSection extends StatefulWidget {
  final ValueChanged<String>? onSpecialtySelected;

  const SpecialityFilterSection({super.key, this.onSpecialtySelected});

  @override
  State<SpecialityFilterSection> createState() => _SpecialityFilterSectionState();
}

class _SpecialityFilterSectionState extends State<SpecialityFilterSection> {
  String selectedSpecialty = 'All';

  final List<String> specialties = [
    'All',
    'General Medicine',
    'Cardiology',
    'Dermatology',
    'Orthopedics',
    'Neurology',
    'Pediatrics',
    'ENT',
    'Gynecology',
  ];

  @override
  Widget build(BuildContext context) {
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
