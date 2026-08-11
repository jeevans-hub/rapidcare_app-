import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../widgets/section_title.dart';
import '../../widgets/health_monitoring/health_monitoring_widgets.dart';

class HealthVitalsScreen extends StatelessWidget {
  HealthVitalsScreen({super.key});

  final List<Map<String, dynamic>> _vitals = [
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
    {
      'vitalName': 'Respiratory Rate',
      'value': '16',
      'unit': 'breaths/min',
      'icon': Icons.air,
    },
    {
      'vitalName': 'Weight',
      'value': '70',
      'unit': 'kg',
      'icon': Icons.scale,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vitals'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Vital Signs',
                  subtitle: 'Demo measurements',
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
                            'Demo data only. These are sample readings for interface demonstration.',
                            style: AppTextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
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
      case 'Respiratory Rate': return '16';
      case 'Weight': return '70';
      default: return '--';
    }
  }

  String _getVitalUnit(String vitalName) {
    switch (vitalName) {
      case 'Heart Rate': return 'BPM';
      case 'Blood Pressure': return 'mmHg';
      case 'Blood Oxygen': return '%';
      case 'Temperature': return '°C';
      case 'Respiratory Rate': return 'breaths/min';
      case 'Weight': return 'kg';
      default: return '';
    }
  }
}
