import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_insurance/health_insurance_widgets.dart';

class InsuranceClaimDetailsScreen extends StatelessWidget {
  const InsuranceClaimDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? claim =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (claim == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Claim Details'),
        ),
        body: const Center(
          child: Text('Claim information not available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Claim Details'),
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
                      Icons.description,
                      size: 64,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  claim['claimTitle'] as String,
                  style: AppTextStyles.headline,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: InsuranceClaimStatusChip(status: claim['status'] as String),
                ),
                const SizedBox(height: AppSpacing.lg),
                InsuranceInfoCard(
                  icon: Icons.receipt_long,
                  title: 'Claim ID',
                  content: claim['claimId'] as String,
                ),
                const SizedBox(height: AppSpacing.md),
                InsuranceInfoCard(
                  icon: Icons.payments,
                  title: 'Claim Amount',
                  content: claim['amount'] as String,
                ),
                const SizedBox(height: AppSpacing.md),
                InsuranceInfoCard(
                  icon: Icons.calendar_today,
                  title: 'Claim Date',
                  content: claim['date'] as String,
                ),
                const SizedBox(height: AppSpacing.lg),
                InsuranceInfoCard(
                  icon: Icons.category,
                  title: 'Claim Type',
                  content: _getClaimType(claim['claimTitle'] as String),
                ),
                const SizedBox(height: AppSpacing.md),
                InsuranceInfoCard(
                  icon: Icons.note,
                  title: 'Description',
                  content: _getClaimDescription(claim['claimTitle'] as String),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(title: 'Submitted Documents'),
                const SizedBox(height: AppSpacing.md),
                _getSubmittedDocuments(claim['claimTitle'] as String),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(title: 'Claim Timeline'),
                const SizedBox(height: AppSpacing.md),
                _buildClaimTimeline(claim['status'] as String),
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
                            'Demo claim record only. No actual claim submission or processing.',
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
                        text: 'View Documents',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.insuranceDocuments);
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

  String _getClaimType(String claimTitle) {
    if (claimTitle.contains('Hospitalization')) return 'Hospitalization';
    if (claimTitle.contains('Medicine')) return 'Reimbursement';
    if (claimTitle.contains('Diagnostic')) return 'Diagnostic';
    if (claimTitle.contains('Emergency')) return 'Emergency';
    if (claimTitle.contains('Specialist')) return 'Consultation';
    return 'General';
  }

  String _getClaimDescription(String claimTitle) {
    switch (claimTitle) {
      case 'Hospitalization Claim':
        return 'Hospitalization expenses for medical treatment at network hospital.';
      case 'Medicine Reimbursement':
        return 'Reimbursement for prescribed medicines purchased from pharmacy.';
      case 'Diagnostic Claim':
        return 'Diagnostic tests and lab investigations as prescribed by doctor.';
      case 'Emergency Room Visit':
        return 'Emergency room visit and treatment for medical emergency.';
      case 'Specialist Consultation':
        return 'Consultation with specialist doctor for medical condition.';
      default:
        return 'General insurance claim for medical expenses.';
    }
  }

  Widget _getSubmittedDocuments(String claimTitle) {
    final documents = _getDocumentsForClaim(claimTitle);
    
    return Column(
      children: documents.map((doc) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          children: [
            const Icon(Icons.insert_drive_file, size: 20, color: AppColors.primaryBlue),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(doc, style: AppTextStyles.caption),
            ),
          ],
        ),
      )).toList(),
    );
  }

  List<String> _getDocumentsForClaim(String claimTitle) {
    switch (claimTitle) {
      case 'Hospitalization Claim':
        return ['Hospital bills', 'Discharge summary', 'Doctor prescriptions', 'ID proof'];
      case 'Medicine Reimbursement':
        return ['Pharmacy bills', 'Doctor prescription', 'Medical certificate'];
      case 'Diagnostic Claim':
        return ['Lab reports', 'Doctor prescription', 'Test requisition form'];
      case 'Emergency Room Visit':
        return ['Emergency room bill', 'Doctor notes', 'Treatment summary'];
      case 'Specialist Consultation':
        return ['Consultation bill', 'Doctor prescription', 'Referral letter'];
      default:
        return ['Medical bills', 'Doctor prescriptions', 'ID proof'];
    }
  }

  Widget _buildClaimTimeline(String status) {
    final timelineSteps = [
      {'title': 'Submitted', 'completed': true},
      {'title': 'Documents Reviewed', 'completed': status != 'Pending'},
      {'title': 'Under Review', 'completed': status == 'Approved' || status == 'Rejected'},
      {'title': status, 'completed': status == 'Approved'},
    ];

    return Column(
      children: timelineSteps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isLast = index == timelineSteps.length - 1;
        
        return Column(
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: step['completed'] as bool ? AppColors.successGreen : AppColors.textSecondaryGrey,
                    shape: BoxShape.circle,
                  ),
                  child: step['completed'] as bool
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    step['title'] as String,
                    style: AppTextStyles.caption.copyWith(
                      color: step['completed'] as bool ? AppColors.textPrimaryDarkGrey : AppColors.textSecondaryGrey,
                    ),
                  ),
                ),
              ],
            ),
            if (!isLast)
              Container(
                margin: const EdgeInsets.only(left: 11, top: AppSpacing.xs, bottom: AppSpacing.xs),
                width: 2,
                height: 20,
                color: step['completed'] as bool ? AppColors.successGreen : AppColors.textSecondaryGrey,
              ),
          ],
        );
      }).toList(),
    );
  }
}
