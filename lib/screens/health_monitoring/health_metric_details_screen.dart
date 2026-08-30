import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/health_metric_model.dart';
import '../../services/health_metric_service.dart';

class HealthMetricDetailsScreen extends StatelessWidget {
  const HealthMetricDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final metric = args is Map && args['metric'] is HealthMetric ? args['metric'] as HealthMetric : null;
    if (metric == null) return const Scaffold(body: Center(child: Text('Metric information not available')));
    return Scaffold(appBar: AppBar(title: const Text('Metric Details')), body: Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(metric.metricType.replaceAll('_', ' '), style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: AppSpacing.md), Text('${metric.value} ${metric.unit}', style: Theme.of(context).textTheme.displaySmall), const SizedBox(height: AppSpacing.md), Text('Recorded: ${metric.recordedAt.toLocal()}'), if (metric.notes != null) Text('Notes: ${metric.notes}'), const Spacer(), OutlinedButton(onPressed: () async { final result = await HealthMetricService.deleteMetric(metric.id); if (context.mounted && result['success'] == true) Navigator.pop(context, true); }, child: const Text('Delete'))])));
  }
}
