import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/medical_records/medical_records_widgets.dart';

class PrescriptionRecordsScreen extends StatelessWidget {
  const PrescriptionRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescriptions'),
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
                  subtitle: 'Your prescription history',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const PrescriptionRecordCard(
                medicineName: 'Paracetamol',
                doctor: 'Dr. Michael Lee',
                hospital: 'City Care Hospital',
                date: '02 Aug 2026',
                dosage: '500mg - Twice daily',
                duration: '7 days',
                status: 'Active',
              ),
              const SizedBox(height: AppSpacing.sm),
              const PrescriptionRecordCard(
                medicineName: 'Vitamin D',
                doctor: 'Dr. Sarah Johnson',
                hospital: 'City Care Hospital',
                date: '28 Jul 2026',
                dosage: '1000 IU - Once daily',
                duration: '30 days',
                status: 'Active',
              ),
              const SizedBox(height: AppSpacing.sm),
              const PrescriptionRecordCard(
                medicineName: 'Amoxicillin',
                doctor: 'Dr. Emily Davis',
                hospital: 'Metro Medical Center',
                date: '15 Jul 2026',
                dosage: '250mg - Three times daily',
                duration: '10 days',
                status: 'Completed',
              ),
              const SizedBox(height: AppSpacing.sm),
              const PrescriptionRecordCard(
                medicineName: 'Ibuprofen',
                doctor: 'Dr. Michael Lee',
                hospital: 'City Care Hospital',
                date: '10 Jul 2026',
                dosage: '400mg - As needed',
                duration: '5 days',
                status: 'Completed',
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
