import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/profile/profile_widgets.dart';

class MedicalInformationScreen extends StatelessWidget {
  const MedicalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Information'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Basic Information'),
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
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Health Information'),
              ),
              const SizedBox(height: AppSpacing.md),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    MedicalInfoCard(
                      icon: Icons.warning,
                      label: 'Allergies',
                      value: 'Penicillin, Peanuts',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    MedicalInfoCard(
                      icon: Icons.medical_information,
                      label: 'Existing Conditions',
                      value: 'Type 2 Diabetes',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    MedicalInfoCard(
                      icon: Icons.medication,
                      label: 'Current Medications',
                      value: 'Metformin 500mg',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Emergency Information'),
              ),
              const SizedBox(height: AppSpacing.md),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    MedicalInfoCard(
                      icon: Icons.contact_phone,
                      label: 'Emergency Contact',
                      value: 'Jane Doe',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    MedicalInfoCard(
                      icon: Icons.family_restroom,
                      label: 'Relationship',
                      value: 'Spouse',
                    ),
                    SizedBox(height: AppSpacing.sm),
                    MedicalInfoCard(
                      icon: Icons.phone,
                      label: 'Phone Number',
                      value: '+1 234 567 8901',
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
