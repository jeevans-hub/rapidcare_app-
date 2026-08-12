import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_reports/health_reports_widgets.dart';

class HealthReportsScreen extends StatelessWidget {
  const HealthReportsScreen({super.key});

  Map<String, String> get _todaySummary => {
    'Steps': '6,420',
    'Sleep': '7h 20m',
    'Water': '5 / 8 glasses',
    'Active Minutes': '24',
  };

  List<Map<String, dynamic>> get _recentReports => [
    {
      'title': 'Weekly Health Summary',
      'category': 'Wellness',
      'date': 'Demo — 18 Aug 2026',
      'description': 'Comprehensive weekly health overview',
      'status': 'Sample',
    },
    {
      'title': 'Vital Signs Report',
      'category': 'Vitals',
      'date': 'Demo — 15 Aug 2026',
      'description': 'Heart rate, blood pressure, oxygen levels',
      'status': 'Sample',
    },
    {
      'title': 'Activity Report',
      'category': 'Activity',
      'date': 'Demo — 12 Aug 2026',
      'description': 'Steps, distance, calories burned',
      'status': 'Sample',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Reports'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HealthReportsHeader(),
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
                            'Demo reports only. This module uses fictional sample data.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(title: 'Latest Summary'),
                const SizedBox(height: AppSpacing.md),
                HealthReportSummaryCard(
                  summary: _todaySummary,
                  reportCount: 7,
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Recent Reports'),
                const SizedBox(height: AppSpacing.md),
                ..._recentReports.map((report) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: HealthReportCard(
                    title: report['title'],
                    category: report['category'],
                    date: report['date'],
                    description: report['description'],
                    status: report['status'],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.healthReportDetails,
                        arguments: report,
                      );
                    },
                  ),
                )),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Quick Access'),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Report Types'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthReportTypes);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Report History'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthReportHistory);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.analytics),
                  title: const Text('Analytics'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthReportAnalytics);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.compare),
                  title: const Text('Comparison'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthReportComparison);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help & Information'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthReportsHelp);
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
