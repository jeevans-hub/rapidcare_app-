import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/doctors/doctor_widgets.dart';

class DoctorSpecialtiesScreen extends StatelessWidget {
  const DoctorSpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Specialties'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose a specialty to find doctors',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                DoctorSpecialtiesGrid(
                  specialties: [
                    SpecialtyItem(
                      icon: Icons.local_hospital,
                      name: 'General Physician',
                      description: 'Primary care and general health services',
                      doctorCount: 25,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                    SpecialtyItem(
                      icon: Icons.favorite,
                      name: 'Cardiologist',
                      description: 'Heart and cardiovascular care',
                      doctorCount: 18,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                    SpecialtyItem(
                      icon: Icons.face,
                      name: 'Dermatologist',
                      description: 'Skin and hair care specialists',
                      doctorCount: 15,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                    SpecialtyItem(
                      icon: Icons.psychology,
                      name: 'Neurologist',
                      description: 'Brain and nervous system specialists',
                      doctorCount: 12,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                    SpecialtyItem(
                      icon: Icons.accessibility,
                      name: 'Orthopedic',
                      description: 'Bone and joint specialists',
                      doctorCount: 14,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                    SpecialtyItem(
                      icon: Icons.child_care,
                      name: 'Pediatrician',
                      description: 'Child health and development',
                      doctorCount: 20,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                    SpecialtyItem(
                      icon: Icons.hearing,
                      name: 'ENT',
                      description: 'Ear, nose, and throat specialists',
                      doctorCount: 10,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                    SpecialtyItem(
                      icon: Icons.pregnant_woman,
                      name: 'Gynecologist',
                      description: 'Women\'s health and pregnancy care',
                      doctorCount: 16,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                    SpecialtyItem(
                      icon: Icons.visibility,
                      name: 'Ophthalmologist',
                      description: 'Eye care and vision specialists',
                      doctorCount: 11,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                    SpecialtyItem(
                      icon: Icons.medical_services,
                      name: 'Dentist',
                      description: 'Dental care and oral health',
                      doctorCount: 22,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.doctorList);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
