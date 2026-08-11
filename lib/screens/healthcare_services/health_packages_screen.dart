import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/section_title.dart';
import '../../widgets/healthcare_services/healthcare_services_widgets.dart';

class HealthPackagesScreen extends StatelessWidget {
  HealthPackagesScreen({super.key});

  final List<Map<String, dynamic>> _packages = [
    {
      'packageName': 'Basic Health Checkup',
      'description': 'Routine health assessment for general wellness',
      'includedServices': [
        'Physical examination',
        'Blood pressure check',
        'Basic blood tests',
        'Health consultation',
      ],
      'duration': '1-2 hours',
    },
    {
      'packageName': 'Comprehensive Health Checkup',
      'description': 'Complete health evaluation with detailed testing',
      'includedServices': [
        'Full physical examination',
        'Complete blood count',
        'Lipid profile',
        'Blood sugar test',
        'Liver function test',
        'Kidney function test',
        'Thyroid test',
      ],
      'duration': '3-4 hours',
    },
    {
      'packageName': 'Senior Wellness Package',
      'description': 'Specialized health assessment for seniors',
      'includedServices': [
        'Comprehensive physical exam',
        'Cardiovascular screening',
        'Bone density test',
        'Diabetes screening',
        'Vision and hearing check',
      ],
      'duration': '3-4 hours',
    },
    {
      'packageName': 'Heart Health Screening',
      'description': 'Focused cardiovascular health assessment',
      'includedServices': [
        'ECG',
        'Echo test',
        'Stress test',
        'Lipid profile',
        'Blood pressure monitoring',
      ],
      'duration': '2-3 hours',
    },
    {
      'packageName': 'Women\'s Wellness Package',
      'description': 'Health assessment tailored for women',
      'includedServices': [
        'Physical examination',
        'Breast screening',
        'Pap smear',
        'Bone density test',
        'Hormone panel',
      ],
      'duration': '2-3 hours',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Checkup Packages'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Health Checkup Packages',
                  subtitle: 'Comprehensive health assessment packages',
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
                            'These are informational package descriptions. No medical recommendations or guarantees are provided.',
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
                      itemCount: _packages.length,
                      itemBuilder: (context, index) {
                        final package = _packages[index];
                        return HealthPackageCard(
                          packageName: package['packageName'],
                          description: package['description'],
                          includedServices: package['includedServices'],
                          duration: package['duration'],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.healthcareServiceDetails,
                              arguments: {
                                'icon': Icons.medical_services,
                                'name': package['packageName'],
                                'description': package['description'],
                                'category': 'Health Package',
                                'status': 'Available',
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
