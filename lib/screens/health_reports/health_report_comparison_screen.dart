import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_reports/health_reports_widgets.dart';

class HealthReportComparisonScreen extends StatelessWidget {
  const HealthReportComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparison'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Report Comparison',
                  subtitle: 'Demo comparison view',
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
                            'Demo comparison for interface demonstration.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('Week 1', style: AppTextStyles.title),
                            const SizedBox(height: AppSpacing.xs),
                            Text('Demo', style: AppTextStyles.small.copyWith(color: AppColors.warningOrange)),
                          ],
                        ),
                        const Icon(Icons.compare_arrows, size: 32, color: AppColors.primaryBlue),
                        Column(
                          children: [
                            Text('Week 2', style: AppTextStyles.title),
                            const SizedBox(height: AppSpacing.xs),
                            Text('Demo', style: AppTextStyles.small.copyWith(color: AppColors.warningOrange)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildComparisonCard(
                  'Steps',
                  '46,000',
                  '47,000',
                  Icons.directions_walk,
                ),
                const SizedBox(height: AppSpacing.md),
                _buildComparisonCard(
                  'Sleep',
                  '51 hours',
                  '52 hours',
                  Icons.bedtime,
                ),
                const SizedBox(height: AppSpacing.md),
                _buildComparisonCard(
                  'Water',
                  '44 glasses',
                  '45 glasses',
                  Icons.water_drop,
                ),
                const SizedBox(height: AppSpacing.md),
                _buildComparisonCard(
                  'Activity',
                  '168 minutes',
                  '170 minutes',
                  Icons.fitness_center,
                ),
                const SizedBox(height: AppSpacing.md),
                _buildComparisonCard(
                  'Heart Rate',
                  '72 BPM',
                  '72 BPM',
                  Icons.favorite,
                ),
                const SizedBox(height: AppSpacing.xl),
                HealthReportInfoCard(
                  icon: Icons.info_outline,
                  title: 'Demo Comparison',
                  content: 'Comparison data is fictional sample data for interface demonstration.',
                ),
                const SizedBox(height: AppSpacing.md),
                HealthReportInfoCard(
                  icon: Icons.warning,
                  title: 'No Medical Interpretation',
                  content: 'Differences shown do not represent medical conclusions or health assessments.',
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonCard(String metric, String week1, String week2, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(icon, size: 32, color: AppColors.primaryBlue),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(metric, style: AppTextStyles.subtitle),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Week 1', style: AppTextStyles.small),
                  Text(week1, style: AppTextStyles.body),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                children: [
                  Text('Week 2', style: AppTextStyles.small),
                  Text(week2, style: AppTextStyles.body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
