import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_reports/health_reports_widgets.dart';

class HealthReportDetailsScreen extends StatelessWidget {
  const HealthReportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? report =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (report == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Report Details'),
        ),
        body: const Center(
          child: Text('Report information not available'),
        ),
      );
    }

    final title = report['title']?.toString() ?? 'Unknown Report';
    final category = report['category']?.toString() ?? 'Unknown Category';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Details'),
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
                  title,
                  style: AppTextStyles.headline,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: Text(
                    category,
                    style: AppTextStyles.subtitle,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Center(
                  child: HealthReportStatusChip(
                    status: 'Demo Report',
                    statusColor: AppColors.warningOrange,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Key Metrics'),
                const SizedBox(height: AppSpacing.md),
                HealthReportMetricCard(
                  metricName: 'Heart Rate',
                  value: '72',
                  unit: 'BPM',
                  date: '18 Aug 2026',
                  icon: Icons.favorite,
                  status: 'Sample',
                ),
                const SizedBox(height: AppSpacing.md),
                HealthReportMetricCard(
                  metricName: 'Blood Oxygen',
                  value: '98',
                  unit: '%',
                  date: '18 Aug 2026',
                  icon: Icons.air,
                  status: 'Sample',
                ),
                const SizedBox(height: AppSpacing.md),
                HealthReportMetricCard(
                  metricName: 'Blood Pressure',
                  value: '120/80',
                  unit: 'mmHg',
                  date: '18 Aug 2026',
                  icon: Icons.bloodtype,
                  status: 'Sample',
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Weekly Trend'),
                const SizedBox(height: AppSpacing.md),
                HealthReportChart(
                  title: 'Heart Rate Trend',
                  data: [70, 73, 72, 75, 71, 74, 72],
                  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Information'),
                const SizedBox(height: AppSpacing.md),
                HealthReportInfoCard(
                  icon: Icons.info_outline,
                  title: 'Sample Report',
                  content: 'Sample value shown for interface demonstration.',
                ),
                const SizedBox(height: AppSpacing.md),
                HealthReportInfoCard(
                  icon: Icons.medical_services,
                  title: 'Medical Consultation',
                  content: 'Health metrics can be discussed with a qualified healthcare professional.',
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
                            'Demo reports only. This module uses fictional sample data.',
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
                PrimaryButton(
                  text: 'Back to Health Reports',
                  onPressed: () {
                    Navigator.pop(context);
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
