import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'health_metric_card.dart';

class HealthMetricsGrid extends StatelessWidget {
  final List<MetricItem> metrics;

  const HealthMetricsGrid({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.0,
          children: metrics.map((metric) {
            return HealthMetricCard(
              icon: metric.icon,
              title: metric.title,
              value: metric.value,
              unit: metric.unit,
              onViewDetails: metric.onViewDetails,
            );
          }).toList(),
        );
      },
    );
  }
}

class MetricItem {
  final IconData icon;
  final String title;
  final String value;
  final String? unit;
  final VoidCallback? onViewDetails;

  MetricItem({
    required this.icon,
    required this.title,
    required this.value,
    this.unit,
    this.onViewDetails,
  });
}
