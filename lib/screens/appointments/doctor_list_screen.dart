import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/appointments/doctor_search_bar.dart';
import '../../widgets/appointments/speciality_filter_section.dart';
import '../../widgets/appointments/doctor_card.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctors'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DoctorSearchBar(),
              const SizedBox(height: AppSpacing.lg),
              const SectionTitle(title: 'Specialities'),
              const SizedBox(height: AppSpacing.md),
              const SpecialityFilterSection(),
              const SizedBox(height: AppSpacing.xl),
              const SectionTitle(title: 'Available Doctors'),
              const SizedBox(height: AppSpacing.md),
              DoctorCard(
                doctorName: 'Dr. Sarah Johnson',
                qualification: 'MBBS, MD',
                specialization: 'Cardiologist',
                hospital: 'City General Hospital',
                experience: 12,
                rating: 4.8,
                reviewCount: 234,
                fee: 600,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.doctorDetails,
                    arguments: {
                      'doctorName': 'Dr. Sarah Johnson',
                      'qualification': 'MBBS, MD',
                      'specialization': 'Cardiologist',
                      'hospital': 'City General Hospital',
                      'experience': 12,
                      'rating': 4.8,
                      'reviewCount': 234,
                      'fee': 600,
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              DoctorCard(
                doctorName: 'Dr. Michael Lee',
                qualification: 'MBBS, MD',
                specialization: 'Dermatologist',
                hospital: 'St. Mary\'s Medical Center',
                experience: 8,
                rating: 4.6,
                reviewCount: 189,
                fee: 500,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.doctorDetails,
                    arguments: {
                      'doctorName': 'Dr. Michael Lee',
                      'qualification': 'MBBS, MD',
                      'specialization': 'Dermatologist',
                      'hospital': 'St. Mary\'s Medical Center',
                      'experience': 8,
                      'rating': 4.6,
                      'reviewCount': 189,
                      'fee': 500,
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              DoctorCard(
                doctorName: 'Dr. Emily Brown',
                qualification: 'MBBS, MS',
                specialization: 'Orthopedic Surgeon',
                hospital: 'Riverside Clinic',
                experience: 15,
                rating: 4.9,
                reviewCount: 312,
                fee: 700,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.doctorDetails,
                    arguments: {
                      'doctorName': 'Dr. Emily Brown',
                      'qualification': 'MBBS, MS',
                      'specialization': 'Orthopedic Surgeon',
                      'hospital': 'Riverside Clinic',
                      'experience': 15,
                      'rating': 4.9,
                      'reviewCount': 312,
                      'fee': 700,
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              DoctorCard(
                doctorName: 'Dr. David Wilson',
                qualification: 'MBBS, MD',
                specialization: 'Neurologist',
                hospital: 'City General Hospital',
                experience: 10,
                rating: 4.7,
                reviewCount: 156,
                fee: 650,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.doctorDetails,
                    arguments: {
                      'doctorName': 'Dr. David Wilson',
                      'qualification': 'MBBS, MD',
                      'specialization': 'Neurologist',
                      'hospital': 'City General Hospital',
                      'experience': 10,
                      'rating': 4.7,
                      'reviewCount': 156,
                      'fee': 650,
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              DoctorCard(
                doctorName: 'Dr. Jennifer Martinez',
                qualification: 'MBBS, MD',
                specialization: 'Pediatrician',
                hospital: 'Children\'s Hospital',
                experience: 7,
                rating: 4.5,
                reviewCount: 98,
                fee: 450,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.doctorDetails,
                    arguments: {
                      'doctorName': 'Dr. Jennifer Martinez',
                      'qualification': 'MBBS, MD',
                      'specialization': 'Pediatrician',
                      'hospital': 'Children\'s Hospital',
                      'experience': 7,
                      'rating': 4.5,
                      'reviewCount': 98,
                      'fee': 450,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
