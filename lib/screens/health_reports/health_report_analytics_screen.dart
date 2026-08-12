import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_reports/health_reports_widgets.dart';

class HealthReportAnalyticsScreen extends StatelessWidget {
  const HealthReportAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Health Analytics',
                  subtitle: 'Demo analytics overview',
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
                            'Demo analytics only. Analytics data is sample data.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                HealthReportSection(
                  title: 'Weekly Activity Trend',
                  children: [
                    HealthReportChart(
                      title: 'Steps (Demo)',
                      data: [5200, 6100, 7450, 6800, 8100, 7200, 6420],
                      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    ),
                  ],
                ),
                HealthReportSection(
                  title: 'Sleep Trend',
                  children: [
                    HealthReportChart(
                      title: 'Sleep Hours (Demo)',
                      data: [7.2, 6.8, 7.5, 8.0, 7.3, 7.8, 7.2],
                      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    ),
                  ],
                ),
                HealthReportSection(
                  title: 'Hydration Progress',
                  children: [
                    HealthReportChart(
                      title: 'Water Glasses (Demo)',
                      data: [5, 6, 7, 8, 6, 7, 5],
                      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    ),
                  ],
                ),
                HealthReportSection(
                  title: 'Vital Measurement History',
                  children: [
                    HealthReportChart(
                      title: 'Heart Rate (Demo)',
                      data: [70, 73, 72, 75, 71, 74, 72],
                      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                HealthReportInfoCard(
                  icon: Icons.info_outline,
                  title: 'Demo Analytics',
                  content: 'Analytics shown are fictional sample data for interface demonstration.',
                ),
                const SizedBox(height: AppSpacing.md),
                HealthReportInfoCard(
                  icon: Icons.warning,
                  title: 'No Medical Interpretation',
                  content: 'These trends do not represent medical conclusions or health assessments.',
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
