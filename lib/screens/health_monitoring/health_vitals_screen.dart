import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/health_metric_model.dart';
import '../../services/health_metric_service.dart';

class HealthVitalsScreen extends StatefulWidget {
  const HealthVitalsScreen({super.key});
  @override
  State<HealthVitalsScreen> createState() => _HealthVitalsScreenState();
}

class _HealthVitalsScreenState extends State<HealthVitalsScreen> {
  List<HealthMetric> _metrics = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await HealthMetricService.getMetrics();
    if (!mounted) return;
    if (result['success'] == true) {
      final data = result['data'] as Map?;
      final list = data?['metrics'] as List? ?? [];
      setState(() {
        _metrics = list
            .whereType<Map>()
            .map(
              (item) => HealthMetric.fromJson(Map<String, dynamic>.from(item)),
            )
            .where(
              (item) => [
                'heart_rate',
                'blood_pressure',
                'blood_sugar',
                'temperature',
                'oxygen_level',
                'weight',
                'height',
              ].contains(item.metricType),
            )
            .toList();
        _loading = false;
      });
    } else {
      setState(() {
        _error = result['message']?.toString() ?? 'Failed to fetch vitals';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Vitals')),
    body: SafeArea(child: _body()),
  );

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!),
            ElevatedButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const Text(
            'These values are for personal tracking only. Consult a qualified medical professional for medical interpretation.',
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_metrics.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Center(child: Text('No vital metrics recorded yet.')),
            ),
          ..._metrics.map(
            (metric) => Card(
              child: ListTile(
                title: Text(metric.metricType.replaceAll('_', ' ')),
                subtitle: Text(metric.recordedAt.toLocal().toString()),
                trailing: Text('${metric.value} ${metric.unit}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
