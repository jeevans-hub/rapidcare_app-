import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/healthcare_services/healthcare_services_widgets.dart';

class LaboratoryServicesScreen extends StatelessWidget {
  LaboratoryServicesScreen({super.key});

  final List<Map<String, dynamic>> _labServices = [
    {
      'serviceName': 'Blood Test',
      'category': 'Hematology',
      'availability': 'Available',
    },
    {
      'serviceName': 'Complete Blood Count',
      'category': 'Hematology',
      'availability': 'Available',
    },
    {
      'serviceName': 'Blood Sugar Test',
      'category': 'Biochemistry',
      'availability': 'Available',
    },
    {
      'serviceName': 'Lipid Profile',
      'category': 'Biochemistry',
      'availability': 'Available',
    },
    {
      'serviceName': 'Thyroid Test',
      'category': 'Endocrinology',
      'availability': 'Available',
    },
    {
      'serviceName': 'Liver Function Test',
      'category': 'Biochemistry',
      'availability': 'Available',
    },
    {
      'serviceName': 'Kidney Function Test',
      'category': 'Biochemistry',
      'availability': 'Available',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laboratory Services'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Laboratory Services',
                  subtitle: 'Diagnostic testing and laboratory services',
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
                            'These are catalogue items only. No actual laboratory testing or result interpretation is provided.',
                            style: Theme.of(context).textTheme.bodySmall,
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
                      itemCount: _labServices.length,
                      itemBuilder: (context, index) {
                        final service = _labServices[index];
                        return LabServiceCard(
                          serviceName: service['serviceName'],
                          category: service['category'],
                          availability: service['availability'],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.healthcareServiceDetails,
                              arguments: {
                                'icon': Icons.science,
                                'name': service['serviceName'],
                                'description': 'Laboratory testing service for ${service['category']}',
                                'category': service['category'],
                                'status': service['availability'],
                              },
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
