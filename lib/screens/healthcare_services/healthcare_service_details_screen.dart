import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/healthcare_services/healthcare_services_widgets.dart';

class HealthcareServiceDetailsScreen extends StatelessWidget {
  const HealthcareServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? service =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (service == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Service Details'),
        ),
        body: const Center(
          child: Text('Service information not available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Details'),
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
                      service['icon'] is IconData 
                          ? service['icon'] as IconData
                          : Icons.local_hospital,
                      size: 64,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  service['name']?.toString() ?? 'Unknown',
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
                      service['category']?.toString() ?? 'Unknown',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                HealthcareServiceInfoCard(
                  icon: Icons.description,
                  title: 'Description',
                  content: service['description']?.toString() ?? 'Not Specified',
                ),
                const SizedBox(height: AppSpacing.md),
                HealthcareServiceInfoCard(
                  icon: Icons.list,
                  title: 'Services Included',
                  content: _getIncludedServices(service['name']?.toString() ?? 'Unknown'),
                ),
                const SizedBox(height: AppSpacing.md),
                HealthcareServiceInfoCard(
                  icon: Icons.schedule,
                  title: 'Availability',
                  content: 'Available on selected days',
                ),
                const SizedBox(height: AppSpacing.md),
                HealthcareServiceInfoCard(
                  icon: Icons.timer,
                  title: 'Estimated Duration',
                  content: '30–60 minutes',
                ),
                const SizedBox(height: AppSpacing.xl),
                Card(
                  color: AppColors.warningOrange.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.warningOrange,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'This is a demo service listing. Contact healthcare providers for actual service availability and booking.',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textPrimaryDarkGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  text: 'Request Service',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('This is a demo feature. No actual request will be made.'),
                        duration: Duration(seconds: 2),
                      ),
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

  String _getIncludedServices(String serviceName) {
    switch (serviceName) {
      case 'Home Nursing':
        return 'Basic nursing assistance, Routine care support, Vital sign recording placeholder, General home-care assistance';
      case 'Physiotherapy at Home':
        return 'Rehabilitation exercises, Mobility training, Pain management techniques, Progress monitoring';
      case 'Basic Health Checkup':
        return 'Physical examination, Vital signs assessment, Basic health screening, Health report';
      case 'Blood Test':
        return 'Complete blood count, Blood sugar test, Lipid profile, Basic blood parameters';
      case 'Elder Care':
        return 'Daily assistance, Medication reminders, Companionship, Safety monitoring';
      default:
        return 'Service-specific care and support as per requirements';
    }
  }
}
