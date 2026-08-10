import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/medical_records/medical_records_widgets.dart';

class LabReportsScreen extends StatelessWidget {
  const LabReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Reports'),
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
                  subtitle: 'Your laboratory test results',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const LabReportCard(
                testName: 'Complete Blood Count',
                hospitalOrLab: 'City Care Hospital',
                date: '10 Aug 2026',
                status: 'Normal',
              ),
              const SizedBox(height: AppSpacing.sm),
              const LabReportCard(
                testName: 'Blood Sugar',
                hospitalOrLab: 'City Care Hospital',
                date: '10 Aug 2026',
                status: 'Normal',
              ),
              const SizedBox(height: AppSpacing.sm),
              const LabReportCard(
                testName: 'Lipid Profile',
                hospitalOrLab: 'Metro Medical Center',
                date: '28 Jul 2026',
                status: 'Normal',
              ),
              const SizedBox(height: AppSpacing.sm),
              const LabReportCard(
                testName: 'Thyroid Function Test',
                hospitalOrLab: 'City Care Hospital',
                date: '15 Jul 2026',
                status: 'Normal',
              ),
              const SizedBox(height: AppSpacing.sm),
              const LabReportCard(
                testName: 'Liver Function Test',
                hospitalOrLab: 'Metro Medical Center',
                date: '10 Jul 2026',
                status: 'Normal',
              ),
              const SizedBox(height: AppSpacing.sm),
              const LabReportCard(
                testName: 'Kidney Function Test',
                hospitalOrLab: 'City Care Hospital',
                date: '05 Jul 2026',
                status: 'Normal',
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
