import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_monitoring/health_monitoring_widgets.dart';

class HealthMetricDetailsScreen extends StatelessWidget {
  const HealthMetricDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? metric =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (metric == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Metric Details'),
        ),
        body: const Center(
          child: Text('Metric information not available'),
        ),
      );
    }

    final metricName = metric['metricName'] as String;
    final value = metric['value'] as String;
    final unit = metric['unit'] as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Metric Details'),
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
                      _getMetricIcon(metricName),
                      size: 64,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  metricName,
                  style: AppTextStyles.headline,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: HealthMetricValue(
                    value: value,
                    unit: unit,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Center(
                  child: HealthMetricStatus(
                    status: 'Demo reading',
                    statusColor: AppColors.warningOrange,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'History'),
                const SizedBox(height: AppSpacing.md),
                HealthMetricChart(
                  title: 'Weekly Trend',
                  data: _getHistoryData(metricName),
                  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                ),
                const SizedBox(height: AppSpacing.lg),
                HealthMetricHistory(
                  history: _getHistoryDetails(metricName),
                ),
                const SizedBox(height: AppSpacing.xl),
                const SectionTitle(title: 'Information'),
                const SizedBox(height: AppSpacing.md),
                HealthMonitoringInfoCard(
                  icon: Icons.info_outline,
                  title: 'Sample Reading',
                  content: 'Sample reading shown for interface demonstration.',
                ),
                const SizedBox(height: AppSpacing.md),
                HealthMonitoringInfoCard(
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
                            'Demo data only. This module does not collect real health measurements.',
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
                  text: 'Back to Health Monitoring',
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

  IconData _getMetricIcon(String metricName) {
    switch (metricName) {
      case 'Heart Rate': return Icons.favorite;
      case 'Blood Pressure': return Icons.bloodtype;
      case 'Blood Oxygen': return Icons.air;
      case 'Temperature': return Icons.thermostat;
      default: return Icons.monitor_heart;
    }
  }

  List<double> _getHistoryData(String metricName) {
    switch (metricName) {
      case 'Heart Rate': return [70, 73, 72, 75, 71, 74, 72];
      case 'Blood Pressure': return [118, 122, 120, 119, 121, 120, 118];
      case 'Blood Oxygen': return [97, 98, 98, 99, 97, 98, 98];
      case 'Temperature': return [36.5, 36.8, 36.7, 36.6, 36.9, 36.7, 36.7];
      default: return [70, 73, 72, 75, 71, 74, 72];
    }
  }

  List<Map<String, dynamic>> _getHistoryDetails(String metricName) {
    final unit = _getUnit(metricName);
    return [
      {'date': '12 Aug 2026', 'value': _getHistoryData(metricName)[0].toString(), 'unit': unit},
      {'date': '11 Aug 2026', 'value': _getHistoryData(metricName)[1].toString(), 'unit': unit},
      {'date': '10 Aug 2026', 'value': _getHistoryData(metricName)[2].toString(), 'unit': unit},
      {'date': '09 Aug 2026', 'value': _getHistoryData(metricName)[3].toString(), 'unit': unit},
      {'date': '08 Aug 2026', 'value': _getHistoryData(metricName)[4].toString(), 'unit': unit},
    ];
  }

  String _getUnit(String metricName) {
    switch (metricName) {
      case 'Heart Rate': return 'BPM';
      case 'Blood Pressure': return 'mmHg';
      case 'Blood Oxygen': return '%';
      case 'Temperature': return '°C';
      default: return '';
    }
  }
}
