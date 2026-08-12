import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_monitoring/health_monitoring_widgets.dart';

class HealthHistoryScreen extends StatefulWidget {
  const HealthHistoryScreen({super.key});

  @override
  State<HealthHistoryScreen> createState() => _HealthHistoryScreenState();
}

class _HealthHistoryScreenState extends State<HealthHistoryScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Vitals',
    'Activity',
    'Sleep',
    'Hydration',
    'Weight',
  ];

  final List<Map<String, dynamic>> _history = [
    {
      'date': '12 Aug 2026',
      'metric': 'Heart Rate',
      'value': '72',
      'unit': 'BPM',
      'category': 'Vitals',
    },
    {
      'date': '11 Aug 2026',
      'metric': 'Blood Oxygen',
      'value': '98',
      'unit': '%',
      'category': 'Vitals',
    },
    {
      'date': '10 Aug 2026',
      'metric': 'Steps',
      'value': '6,420',
      'unit': 'steps',
      'category': 'Activity',
    },
    {
      'date': '09 Aug 2026',
      'metric': 'Sleep',
      'value': '7h 20m',
      'unit': 'hours',
      'category': 'Sleep',
    },
    {
      'date': '08 Aug 2026',
      'metric': 'Water',
      'value': '5 / 8',
      'unit': 'glasses',
      'category': 'Hydration',
    },
    {
      'date': '07 Aug 2026',
      'metric': 'Weight',
      'value': '70',
      'unit': 'kg',
      'category': 'Weight',
    },
    {
      'date': '06 Aug 2026',
      'metric': 'Blood Pressure',
      'value': '120/80',
      'unit': 'mmHg',
      'category': 'Vitals',
    },
    {
      'date': '05 Aug 2026',
      'metric': 'Temperature',
      'value': '36.7',
      'unit': '°C',
      'category': 'Vitals',
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
        title: const Text('Health History'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Health History',
                  subtitle: 'Demo historical records',
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
                            'Demo data only. Historical records are sample data.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                HealthMonitoringFilters(
                  filters: _filters,
                  selectedFilter: _selectedFilter,
                  onFilterChanged: (filter) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                if (filteredHistory.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: AppColors.textSecondaryGrey,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'No sample records found',
                            style: AppTextStyles.title,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Try another filter.',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...filteredHistory.map((entry) => Card(
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
                            child: Text(entry['metric'], style: AppTextStyles.body),
                          ),
                          Expanded(
                            child: Text(entry['value'], style: AppTextStyles.subtitle),
                          ),
                          Expanded(
                            child: Text(entry['unit'], style: AppTextStyles.caption),
                          ),
                          Expanded(
                            child: Text('Demo', style: AppTextStyles.small.copyWith(color: AppColors.warningOrange)),
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
