import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/health_metric_model.dart';
import '../../services/health_metric_service.dart';

class HealthHistoryScreen extends StatefulWidget {
  const HealthHistoryScreen({super.key});
  @override
  State<HealthHistoryScreen> createState() => _HealthHistoryScreenState();
}

class _HealthHistoryScreenState extends State<HealthHistoryScreen> {
  List<HealthMetric> _metrics = [];
  bool _loading = true;
  String? _error;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
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
            .toList();
        _loading = false;
      });
    } else {
      setState(() {
        _error =
            result['message']?.toString() ?? 'Failed to fetch health history';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Health History')),
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
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.xl),
                child: Text('No health metrics recorded yet.'),
              ),
            ),
          ..._metrics.map(
            (metric) => Card(
              child: ListTile(
                title: Text(metric.metricType.replaceAll('_', ' ')),
                subtitle: Text(
                  '${metric.recordedAt.toLocal()}\n${metric.notes ?? ''}',
                ),
                isThreeLine: metric.notes != null,
                trailing: Text('${metric.value} ${metric.unit}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
