import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_reports/health_reports_widgets.dart';

class HealthReportHistoryScreen extends StatefulWidget {
  const HealthReportHistoryScreen({super.key});

  @override
  State<HealthReportHistoryScreen> createState() => _HealthReportHistoryScreenState();
}

class _HealthReportHistoryScreenState extends State<HealthReportHistoryScreen> {
  String _selectedFilter = 'All';

  List<String> get _filters => [
    'All',
    'Vitals',
    'Activity',
    'Sleep',
    'Hydration',
    'Weight',
    'Wellness',
  ];

  List<Map<String, dynamic>> get _history => [
    {
      'date': '18 Aug 2026',
      'title': 'Weekly Health Summary',
      'category': 'Wellness',
      'status': 'Demo',
    },
    {
      'date': '15 Aug 2026',
      'title': 'Vital Signs Report',
      'category': 'Vitals',
      'status': 'Demo',
    },
    {
      'date': '12 Aug 2026',
      'title': 'Activity Report',
      'category': 'Activity',
      'status': 'Demo',
    },
    {
      'date': '10 Aug 2026',
      'title': 'Sleep Report',
      'category': 'Sleep',
      'status': 'Demo',
    },
    {
      'date': '08 Aug 2026',
      'title': 'Hydration Report',
      'category': 'Hydration',
      'status': 'Demo',
    },
    {
      'date': '05 Aug 2026',
      'title': 'Weight Report',
      'category': 'Weight',
      'status': 'Demo',
    },
    {
      'date': '02 Aug 2026',
      'title': 'Wellness Summary',
      'category': 'Wellness',
      'status': 'Demo',
    },
  ];

  List<Map<String, dynamic>> _getFilteredHistory() {
    if (_selectedFilter == 'All') return _history;
    return _history.where((entry) {
      return entry['category'] == _selectedFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredHistory = _getFilteredHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report History'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Report History',
                  subtitle: 'Demo historical reports',
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
                            'Demo reports only. Historical reports are sample data.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                HealthReportFilters(
                  filters: _filters,
                  selectedFilter: _selectedFilter,
                  onFilterChanged: (filter) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                ...filteredHistory.map((entry) => Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.healthReportDetails,
                        arguments: {
                          'title': entry['title'],
                          'category': entry['category'],
                          'date': 'Demo — ${entry['date']}',
                          'description': 'Historical report',
                          'status': entry['status'],
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(entry['date'], style: AppTextStyles.body),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(entry['title'], style: AppTextStyles.body),
                          ),
                          Expanded(
                            child: Text(entry['category'], style: AppTextStyles.caption),
                          ),
                          Expanded(
                            child: Text('Demo', style: AppTextStyles.small.copyWith(color: AppColors.warningOrange)),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondaryGrey),
                        ],
                      ),
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
