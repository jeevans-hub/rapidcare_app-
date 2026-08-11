import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_monitoring/health_monitoring_widgets.dart';

class HealthActivityScreen extends StatelessWidget {
  const HealthActivityScreen({super.key});

  List<Map<String, dynamic>> get _weeklyActivity => [
    {'day': 'Monday', 'steps': '5,200', 'distance': '3.5 km', 'calories': '210'},
    {'day': 'Tuesday', 'steps': '6,100', 'distance': '4.1 km', 'calories': '245'},
    {'day': 'Wednesday', 'steps': '7,450', 'distance': '5.0 km', 'calories': '300'},
    {'day': 'Thursday', 'steps': '6,800', 'distance': '4.6 km', 'calories': '275'},
    {'day': 'Friday', 'steps': '8,100', 'distance': '5.5 km', 'calories': '325'},
    {'day': 'Saturday', 'steps': '7,200', 'distance': '4.8 km', 'calories': '290'},
    {'day': 'Sunday', 'steps': '6,420', 'distance': '4.3 km', 'calories': '260'},
  ];

  @override
  Widget build(BuildContext context) {
    final totalSteps = _weeklyActivity.fold<int>(
      0,
      (sum, item) => sum + int.parse(item['steps'].toString().replaceAll(',', '')),
    );
    final averageSteps = (totalSteps / 7).toInt();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Activity Tracking',
                  subtitle: 'Demo activity data',
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
                            'Demo data only. Activity tracking information is sample data.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(title: 'Weekly Overview'),
                const SizedBox(height: AppSpacing.md),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.directions_walk, color: AppColors.secondaryTeal),
                            const SizedBox(width: AppSpacing.sm),
                            Text('Total Steps: $totalSteps', style: AppTextStyles.title),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            const Icon(Icons.analytics, color: AppColors.secondaryTeal),
                            const SizedBox(width: AppSpacing.sm),
                            Text('Daily Average: $averageSteps', style: AppTextStyles.subtitle),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(title: 'Daily Activity'),
                const SizedBox(height: AppSpacing.md),
                HealthMetricChart(
                  title: 'Weekly Steps',
                  data: [5200, 6100, 7450, 6800, 8100, 7200, 6420],
                  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                ),
                const SizedBox(height: AppSpacing.lg),
                ..._weeklyActivity.map((activity) => Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(activity['day'], style: AppTextStyles.title),
                        ),
                        Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${activity['steps']} steps', style: AppTextStyles.body),
                            Text(activity['distance'], style: AppTextStyles.caption),
                          ],
                        ),
                        ),
                        Expanded(
                          child: Text('${activity['calories']} kcal', style: AppTextStyles.subtitle),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
