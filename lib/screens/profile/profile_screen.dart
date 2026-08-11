import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/profile/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                name: 'John Doe',
                email: 'john.doe@example.com',
                onEditTap: () {
                  Navigator.pushNamed(context, AppRoutes.editProfile);
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: ProfileStatisticsCard(
                  appointments: 12,
                  prescriptions: 5,
                  healthRecords: 8,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Personal Information'),
              ),
              const SizedBox(height: AppSpacing.md),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    ProfileInfoCard(
                      icon: Icons.person,
                      label: 'Full Name',
                      value: 'John Doe',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    ProfileInfoCard(
                      icon: Icons.email,
                      label: 'Email',
                      value: 'john.doe@example.com',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    ProfileInfoCard(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: '+1 234 567 8900',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    ProfileInfoCard(
                      icon: Icons.cake,
                      label: 'Date of Birth',
                      value: 'Jan 15, 1990',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Medical Information'),
              ),
              const SizedBox(height: AppSpacing.md),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    MedicalInfoCard(
                      icon: Icons.bloodtype,
                      label: 'Blood Group',
                      value: 'O+',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    MedicalInfoCard(
                      icon: Icons.height,
                      label: 'Height',
                      value: '175 cm',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    MedicalInfoCard(
                      icon: Icons.monitor_weight,
                      label: 'Weight',
                      value: '70 kg',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    MedicalInfoCard(
                      icon: Icons.contact_phone,
                      label: 'Emergency Contact',
                      value: 'Jane Doe (Spouse)',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Menu'),
              ),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.calendar_today,
                      title: 'My Appointments',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.appointments);
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ProfileMenuItem(
                      icon: Icons.medication,
                      title: 'Pharmacy Orders',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.pharmacyHome);
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ProfileMenuItem(
                      icon: Icons.folder_open,
                      title: 'Medical Records',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.medicalRecords);
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ProfileMenuItem(
                      icon: Icons.local_hospital,
                      title: 'Healthcare Services',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.healthcareServices);
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ProfileMenuItem(
                      icon: Icons.contacts,
                      title: 'Emergency Contacts',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.emergencyContacts);
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ProfileMenuItem(
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.settings);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
