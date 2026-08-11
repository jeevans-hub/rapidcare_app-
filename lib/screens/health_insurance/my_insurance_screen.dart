import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_insurance/health_insurance_widgets.dart';

class MyInsuranceScreen extends StatelessWidget {
  const MyInsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Insurance'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'My Active Policy',
                  subtitle: 'Demo policy information',
                ),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shield,
                              size: 48,
                              color: AppColors.primaryBlue,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RapidCare Health Shield',
                                    style: AppTextStyles.title,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  InsuranceClaimStatusChip(status: 'Active'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        InsuranceInfoCard(
                          icon: Icons.receipt_long,
                          title: 'Policy Number',
                          content: 'DEMO-RC-2026-001',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        InsuranceInfoCard(
                          icon: Icons.security,
                          title: 'Coverage Amount',
                          content: '₹10,00,000',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        InsuranceInfoCard(
                          icon: Icons.calendar_today,
                          title: 'Valid Until',
                          content: '31 December 2026',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Card(
                          color: AppColors.warningOrange.withValues(alpha: 0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, color: AppColors.warningOrange, size: 16),
                                const SizedBox(width: AppSpacing.sm),
                                Text(
                                  'DEMO POLICY - Not a real insurance policy',
                                  style: AppTextStyles.small,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.insuranceClaims);
                                },
                                child: const Text('View Claims'),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.insuranceDocuments);
                                },
                                child: const Text('Documents'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(
                  title: 'Policy Benefits',
                ),
                const SizedBox(height: AppSpacing.md),
                InsuranceBenefitsCard(
                  title: 'Your Coverage Includes',
                  benefits: [
                    'Cashless hospitalization at network hospitals',
                    'Pre and post hospitalization coverage',
                    'Day care procedures covered',
                    'Ambulance coverage up to ₹5,000',
                    'No claim bonus accumulation',
                    'Tax benefits under Section 80D',
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(
                  title: 'Quick Actions',
                ),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('File a Claim'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.insuranceClaims);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.folder_open),
                  title: const Text('View Documents'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.insuranceDocuments);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Get Help'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.insuranceHelp);
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
