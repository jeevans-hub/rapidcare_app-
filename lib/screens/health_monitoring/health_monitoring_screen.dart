import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_monitoring/health_monitoring_widgets.dart';

class HealthMonitoringScreen extends StatelessWidget {
  const HealthMonitoringScreen({super.key});

  Map<String, String> get _todaySummary => {
    'Steps': '6,420',
    'Sleep': '7h 20m',
    'Water': '5 / 8 glasses',
    'Active Minutes': '24',
  };

  List<Map<String, dynamic>> get _vitals => [
    {
      'vitalName': 'Heart Rate',
      'value': '72',
      'unit': 'BPM',
      'icon': Icons.favorite,
    },
    {
      'vitalName': 'Blood Pressure',
      'value': '120/80',
      'unit': 'mmHg',
      'icon': Icons.bloodtype,
    },
    {
      'vitalName': 'Blood Oxygen',
      'value': '98',
      'unit': '%',
      'icon': Icons.air,
    },
    {
      'vitalName': 'Temperature',
      'value': '36.7',
      'unit': '°C',
      'icon': Icons.thermostat,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Monitoring'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HealthMonitoringHeader(),
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
                            'Demo data only. This module does not collect real health measurements.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionTitle(title: 'Today\'s Summary'),
                const SizedBox(height: AppSpacing.md),
                HealthSummaryCard(summary: _todaySummary),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Vital Metrics'),
                const SizedBox(height: AppSpacing.md),
                HealthVitalsGrid(
                  vitals: _vitals,
                  onVitalTap: (vitalName) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.healthMetricDetails,
                      arguments: {
                        'metricName': vitalName,
                        'value': _getVitalValue(vitalName),
                        'unit': _getVitalUnit(vitalName),
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Quick Access'),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  leading: const Icon(Icons.monitor_heart),
                  title: const Text('All Vitals'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthVitals);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.directions_walk),
                  title: const Text('Activity'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthActivity);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.flag),
                  title: const Text('Health Goals'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthGoals);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Health History'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthHistory);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.assessment),
                  title: const Text('Health Reports'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthReports);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help & Information'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.healthMonitoringHelp);
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

  String _getVitalValue(String vitalName) {
    switch (vitalName) {
      case 'Heart Rate': return '72';
      case 'Blood Pressure': return '120/80';
      case 'Blood Oxygen': return '98';
      case 'Temperature': return '36.7';
      default: return '--';
    }
  }

  String _getVitalUnit(String vitalName) {
    switch (vitalName) {
      case 'Heart Rate': return 'BPM';
      case 'Blood Pressure': return 'mmHg';
      case 'Blood Oxygen': return '%';
      case 'Temperature': return '°C';
      default: return '';
    }
  }
}
