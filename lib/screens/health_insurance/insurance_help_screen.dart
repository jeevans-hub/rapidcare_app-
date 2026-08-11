import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';

class InsuranceHelpScreen extends StatelessWidget {
  InsuranceHelpScreen({super.key});

  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'What is health insurance?',
      'answer': 'Health insurance is a contract between you and an insurance company that helps cover medical expenses. You pay premiums, and the insurer agrees to pay part or all of your healthcare costs.',
    },
    {
      'question': 'What does hospitalization coverage mean?',
      'answer': 'Hospitalization coverage includes expenses related to hospital stays such as room rent, ICU charges, surgery costs, doctor fees, and medicines administered during hospitalization.',
    },
    {
      'question': 'What is a deductible?',
      'answer': 'A deductible is the amount you pay out-of-pocket before your insurance starts covering expenses. For example, if you have a ₹10,000 deductible, you pay the first ₹10,000 of covered services.',
    },
    {
      'question': 'What is a claim?',
      'answer': 'A claim is a formal request to your insurance company for payment of covered medical expenses. You can file claims for cashless hospitalization or reimbursement of expenses you have already paid.',
    },
    {
      'question': 'How does reimbursement work?',
      'answer': 'In reimbursement, you pay medical expenses first, then submit bills and documents to your insurer. The insurer reviews and pays you back according to your policy coverage.',
    },
    {
      'question': 'What documents are normally required?',
      'answer': 'Common documents include hospital bills, discharge summary, doctor prescriptions, lab reports, ID proof, and claim forms. Specific requirements vary by claim type.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Help'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Frequently Asked Questions',
                  subtitle: 'Common insurance questions answered',
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
                            'This is informational content only. For actual insurance advice, consult a licensed insurance advisor.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ..._faqs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final faq = entry.value;
                  return _buildFAQCard(
                    question: faq['question'] as String,
                    answer: faq['answer'] as String,
                    index: index,
                  );
                }),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Contact Support'),
                const SizedBox(height: AppSpacing.md),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support_agent,
                              color: AppColors.primaryBlue,
                              size: 32,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Need Help?',
                                    style: AppTextStyles.title,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    'Our support team is here to assist you',
                                    style: AppTextStyles.caption,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        _buildContactOption(
                          icon: Icons.phone,
                          title: 'Call Support',
                          subtitle: '1800-XXX-XXXX (Demo)',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _buildContactOption(
                          icon: Icons.email,
                          title: 'Email Support',
                          subtitle: 'support@rapidcare.demo (Demo)',
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _buildContactOption(
                          icon: Icons.chat,
                          title: 'Live Chat',
                          subtitle: 'Available 24/7 (Demo)',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQCard({
    required String question,
    required String answer,
    required int index,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
          child: Text(
            '${index + 1}',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primaryBlue,
            ),
          ),
        ),
        title: Text(
          question,
          style: AppTextStyles.subtitle,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              answer,
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () {
        // Demo contact action
      },
      borderRadius: BorderRadius.circular(AppRadius.small),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryBlue,
              size: 24,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondaryGrey,
            ),
          ],
        ),
      ),
    );
  }
}
