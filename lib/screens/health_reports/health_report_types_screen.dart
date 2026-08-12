import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_reports/health_reports_widgets.dart';

class HealthReportTypesScreen extends StatelessWidget {
  const HealthReportTypesScreen({super.key});

  List<Map<String, dynamic>> get _reportTypes => [
    {
      'icon': Icons.favorite,
      'title': 'Vital Signs',
      'description': 'Heart rate, blood pressure, oxygen levels',
      'reportCount': 5,
    },
    {
      'icon': Icons.directions_walk,
      'title': 'Activity',
      'description': 'Steps, distance, calories burned',
      'reportCount': 4,
    },
    {
      'icon': Icons.bedtime,
      'title': 'Sleep',
      'description': 'Sleep duration and quality',
      'reportCount': 3,
    },
    {
      'icon': Icons.water_drop,
      'title': 'Hydration',
      'description': 'Water intake tracking',
      'reportCount': 3,
    },
    {
      'icon': Icons.scale,
      'title': 'Weight',
      'description': 'Weight measurements',
      'reportCount': 2,
    },
    {
      'icon': Icons.favorite_border,
      'title': 'Wellness',
      'description': 'Overall wellness summary',
      'reportCount': 4,
    },
    {
      'icon': Icons.monitor_heart,
      'title': 'Health Monitoring',
      'description': 'Comprehensive health monitoring reports',
      'reportCount': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Types'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Available Report Types',
                  subtitle: 'Demo report categories',
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
                            'Demo reports only. Report categories are sample data.',
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
                      itemCount: _reportTypes.length,
                      itemBuilder: (context, index) {
                        final type = _reportTypes[index];
                        return HealthReportTypeCard(
                          icon: type['icon'],
                          title: type['title'],
                          description: type['description'],
                          reportCount: type['reportCount'],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.healthReportDetails,
                              arguments: {
                                'title': '${type['title']} Report',
                                'category': type['title'],
                                'date': 'Demo — 18 Aug 2026',
                                'description': type['description'],
                                'status': 'Sample',
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
