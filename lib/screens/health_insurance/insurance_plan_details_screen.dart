import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/health_insurance/health_insurance_widgets.dart';

class InsurancePlanDetailsScreen extends StatelessWidget {
  const InsurancePlanDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? plan =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (plan == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Plan Details'),
        ),
        body: const Center(
          child: Text('Plan information not available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shield,
                      size: 64,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  plan['planName'] as String,
                  style: AppTextStyles.headline,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlueLight.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                    ),
                    child: Text(
                      plan['category'] as String,
                      style: AppTextStyles.caption,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                InsuranceCoverageCard(
                  title: 'Coverage Amount',
                  coverageAmount: plan['coverageAmount'] as String,
                  description: 'Sum insured for the policy',
                ),
                const SizedBox(height: AppSpacing.md),
                InsuranceInfoCard(
                  icon: Icons.payments,
                  title: 'Illustrative Premium',
                  content: plan['premium'] as String,
                ),
                const SizedBox(height: AppSpacing.md),
                InsuranceInfoCard(
                  icon: Icons.description,
                  title: 'Description',
                  content: plan['description'] as String,
                ),
                const SizedBox(height: AppSpacing.lg),
                InsuranceBenefitsCard(
                  title: 'Key Benefits',
                  benefits: _getPlanBenefits(plan['planName'] as String),
                ),
                const SizedBox(height: AppSpacing.lg),
                InsuranceBenefitsCard(
                  title: 'Coverage Details',
                  benefits: _getCoverageDetails(plan['planName'] as String),
                ),
                const SizedBox(height: AppSpacing.lg),
                InsuranceBenefitsCard(
                  title: 'Exclusions',
                  benefits: [
                    'Pre-existing diseases (waiting period applies)',
                    'Cosmetic procedures',
                    'Self-inflicted injuries',
                    'Alternative treatments',
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                InsuranceInfoCard(
                  icon: Icons.verified_user,
                  title: 'Eligibility',
                  content: 'Individuals aged 18-65 years. No pre-existing condition coverage in first 30 days.',
                ),
                const SizedBox(height: AppSpacing.lg),
                InsuranceInfoCard(
                  icon: Icons.contact_support,
                  title: 'Claim Information',
                  content: 'Claims can be submitted through cashless hospitalization or reimbursement. Documents required: medical reports, bills, prescriptions.',
                ),
                const SizedBox(height: AppSpacing.xl),
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
                            'Demo information only — not an actual insurance policy. No policy purchase is available.',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textPrimaryDarkGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: 'View Coverage',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Coverage details are demo information only.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Contact Support',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.insuranceHelp);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> _getPlanBenefits(String planName) {
    switch (planName) {
      case 'Basic Health Cover':
        return [
          'Cashless hospitalization up to ₹5,00,000',
          'Pre-hospitalization: 30 days',
          'Post-hospitalization: 60 days',
          'Day care procedures covered',
          'Ambulance coverage: ₹2,000',
        ];
      case 'Comprehensive Health Cover':
        return [
          'Cashless hospitalization up to ₹10,00,000',
          'Pre-hospitalization: 60 days',
          'Post-hospitalization: 90 days',
          'Day care procedures covered',
          'Ambulance coverage: ₹5,000',
          'No claim bonus up to 50%',
        ];
      case 'Family Health Plan':
        return [
          'Family floater coverage up to ₹15,00,000',
          'Includes spouse and children',
          'Pre-hospitalization: 60 days',
          'Post-hospitalization: 90 days',
          'Maternity coverage after waiting period',
          'Newborn baby coverage',
        ];
      case 'Senior Citizen Health Plan':
        return [
          'Coverage for seniors aged 60+',
          'No medical tests up to certain age',
          'Pre-existing disease coverage after waiting period',
          'Specialized senior care benefits',
          'Free health checkups annually',
        ];
      case 'Critical Care Protection':
        return [
          'Coverage for 20+ critical illnesses',
          'Lump sum benefit on diagnosis',
          'Independent of other health insurance',
          'Tax benefits under Section 80D',
          'No hospitalization required for claim',
        ];
      default:
        return [
          'Cashless hospitalization',
          'Pre and post hospitalization coverage',
          'Day care procedures covered',
          'No claim bonus benefits',
        ];
    }
  }

  List<String> _getCoverageDetails(String planName) {
    switch (planName) {
      case 'Basic Health Cover':
        return [
          'Room rent: ₹3,000 per day',
          'ICU charges: Covered',
          'Surgery expenses: Covered',
          'Doctor consultation: Covered',
        ];
      case 'Comprehensive Health Cover':
        return [
          'Room rent: ₹5,000 per day',
          'ICU charges: Covered',
          'Surgery expenses: Covered',
          'Doctor consultation: Covered',
          'Organ donor expenses: Covered',
        ];
      case 'Family Health Plan':
        return [
          'Family floater sum insured',
          'Individual limits apply',
          'Maternity coverage: ₹50,000',
          'Newborn baby coverage: Up to policy limit',
        ];
      case 'Senior Citizen Health Plan':
        return [
          'Room rent: ₹4,000 per day',
          'ICU charges: Covered',
          'Specialized senior care',
          'Domiciliary hospitalization: Covered',
        ];
      case 'Critical Care Protection':
        return [
          'Lump sum benefit on diagnosis',
          'Covers major critical illnesses',
          'Independent of hospitalization',
          'No sub-limits on certain conditions',
        ];
      default:
        return [
          'Hospitalization expenses',
          'Surgery and procedures',
          'Doctor consultation fees',
          'Medicine costs during hospitalization',
        ];
    }
  }
}
