import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';

class MedicalRecordDetailsScreen extends StatelessWidget {
  const MedicalRecordDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Record'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.biotech,
                    size: 50,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  'Blood Test',
                  style: AppTextStyles.headline,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  'City Care Hospital',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  '10 Aug 2026',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warningOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.small),
                  ),
                  child: const Text(
                    'Lab Report',
                    style: AppTextStyles.caption,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Record Summary'),
              ),
              const SizedBox(height: AppSpacing.md),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: _DetailRow(label: 'Diagnosis', value: 'Routine health examination'),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: _DetailRow(label: 'Notes', value: 'Patient advised to maintain a healthy lifestyle.'),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: _DetailRow(label: 'Doctor', value: 'Dr. Sarah Johnson'),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: _DetailRow(label: 'Department', value: 'Pathology'),
              ),
              const SizedBox(height: AppSpacing.xl),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: SectionTitle(title: 'Details'),
              ),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWhite,
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    border: Border.all(color: AppColors.backgroundLightGreyDark),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Test Results',
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _ResultItem(name: 'Hemoglobin', value: '13.5 g/dL', status: 'Normal'),
                      _ResultItem(name: 'WBC Count', value: '7,500 /mm³', status: 'Normal'),
                      _ResultItem(name: 'Platelet Count', value: '250,000 /mm³', status: 'Normal'),
                      _ResultItem(name: 'Blood Sugar', value: '95 mg/dL', status: 'Normal'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: 'View Report',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Report preview is not available in demo mode.'),
                              backgroundColor: AppColors.warningOrange,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Download Report',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Report preview is not available in demo mode.'),
                              backgroundColor: AppColors.warningOrange,
                            ),
                          );
                        },
                      ),
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.body,
          ),
        ),
      ],
    );
  }
}

class _ResultItem extends StatelessWidget {
  final String name;
  final String value;
  final String status;

  const _ResultItem({
    required this.name,
    required this.value,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: AppTextStyles.body,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: status == 'Normal'
                  ? AppColors.successGreen.withValues(alpha: 0.1)
                  : AppColors.errorRed.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.small),
            ),
            child: Text(
              status,
              style: AppTextStyles.small.copyWith(
                color: status == 'Normal'
                    ? AppColors.successGreen
                    : AppColors.errorRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
