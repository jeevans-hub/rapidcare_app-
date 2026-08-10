import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/medical_records/medical_records_widgets.dart';

class DoctorReportsScreen extends StatelessWidget {
  const DoctorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Reports'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: MedicalRecordsHeader(
                  subtitle: 'Your consultation reports',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              DoctorReportCard(
                doctorName: 'Dr. Sarah Johnson',
                specialization: 'General Physician',
                hospital: 'City Care Hospital',
                visitDate: '05 Aug 2026',
                diagnosis: 'Routine health examination',
                followUp: 'No follow-up required',
                onViewDetails: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              DoctorReportCard(
                doctorName: 'Dr. Emily Davis',
                specialization: 'Cardiologist',
                hospital: 'Metro Medical Center',
                visitDate: '20 Jul 2026',
                diagnosis: 'Cardiac checkup - Normal',
                followUp: 'Next checkup in 6 months',
                onViewDetails: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              DoctorReportCard(
                doctorName: 'Dr. Michael Lee',
                specialization: 'General Physician',
                hospital: 'City Care Hospital',
                visitDate: '15 Jul 2026',
                diagnosis: 'Mild respiratory infection',
                followUp: 'Follow-up after medication',
                onViewDetails: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              DoctorReportCard(
                doctorName: 'Dr. Robert Chen',
                specialization: 'Dermatologist',
                hospital: 'Metro Medical Center',
                visitDate: '10 Jul 2026',
                diagnosis: 'Skin allergy - Mild',
                followUp: 'Monitor for 2 weeks',
                onViewDetails: () {},
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
