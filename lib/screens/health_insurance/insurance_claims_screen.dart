import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_insurance/health_insurance_widgets.dart';

class InsuranceClaimsScreen extends StatelessWidget {
  InsuranceClaimsScreen({super.key});

  final List<Map<String, dynamic>> _claims = [
    {
      'claimTitle': 'Hospitalization Claim',
      'claimId': 'CLM-2026-001',
      'amount': '₹45,000',
      'date': '12 July 2026',
      'status': 'Approved',
    },
    {
      'claimTitle': 'Medicine Reimbursement',
      'claimId': 'CLM-2026-002',
      'amount': '₹5,500',
      'date': '05 July 2026',
      'status': 'Under Review',
    },
    {
      'claimTitle': 'Diagnostic Claim',
      'claimId': 'CLM-2026-003',
      'amount': '₹3,200',
      'date': '28 June 2026',
      'status': 'Rejected',
    },
    {
      'claimTitle': 'Emergency Room Visit',
      'claimId': 'CLM-2026-004',
      'amount': '₹12,000',
      'date': '15 June 2026',
      'status': 'Approved',
    },
    {
      'claimTitle': 'Specialist Consultation',
      'claimId': 'CLM-2026-005',
      'amount': '₹2,500',
      'date': '08 June 2026',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Claims'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'My Claims',
                  subtitle: 'Demo claim records',
                ),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  color: AppColors.warningOrange.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.warningOrange),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'These are demo claim records only. No actual claim submission is available.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                    
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: AppSpacing.md,
                        crossAxisSpacing: AppSpacing.md,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: _claims.length,
                      itemBuilder: (context, index) {
                        final claim = _claims[index];
                        return InsuranceClaimCard(
                          claimTitle: claim['claimTitle'],
                          claimId: claim['claimId'],
                          amount: claim['amount'],
                          date: claim['date'],
                          status: claim['status'],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.insuranceClaimDetails,
                              arguments: claim,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
