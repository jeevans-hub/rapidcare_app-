import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/health/health_widgets.dart';

class HealthMetricsScreen extends StatelessWidget {
  const HealthMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Metrics'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: HealthHeader(
                  subtitle: 'Monitor your vital health indicators',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: HealthMetricsGrid(
                  metrics: [
                    MetricItem(
                      icon: Icons.directions_walk,
                      title: 'Steps',
                      value: '6,420',
                      unit: 'steps',
                    ),
                    MetricItem(
                      icon: Icons.favorite,
                      title: 'Heart Rate',
                      value: '--',
                      unit: 'bpm',
                    ),
                    MetricItem(
                      icon: Icons.monitor_heart,
                      title: 'Blood Pressure',
                      value: '-- / --',
                      unit: 'mmHg',
                    ),
                    MetricItem(
                      icon: Icons.monitor_weight,
                      title: 'Weight',
                      value: '68',
                      unit: 'kg',
                    ),
                    MetricItem(
                      icon: Icons.straighten,
                      title: 'BMI',
                      value: '--',
                    ),
                    MetricItem(
                      icon: Icons.thermostat,
                      title: 'Body Temperature',
                      value: '--',
                      unit: '°C',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
