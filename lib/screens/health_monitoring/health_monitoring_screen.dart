import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/health_metric_model.dart';
import '../../services/health_metric_service.dart';

class HealthMonitoringScreen extends StatefulWidget {
  const HealthMonitoringScreen({super.key});
  @override
  State<HealthMonitoringScreen> createState() => _HealthMonitoringScreenState();
}

class _HealthMonitoringScreenState extends State<HealthMonitoringScreen> {
  List<HealthMetric> _metrics = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    final result = await HealthMetricService.getMetrics();
    if (!mounted) return;
    if (result['success'] == true) { final data = result['data'] as Map?; final values = data?['metrics'] as List? ?? []; setState(() { _metrics = values.whereType<Map>().map((item) => HealthMetric.fromJson(Map<String, dynamic>.from(item))).toList(); _loading = false; }); } else setState(() { _error = result['message']?.toString() ?? 'Failed to fetch health metrics'; _loading = false; });
  }

  Future<void> _add() async {
    final values = await showDialog<Map<String, String>>(context: context, builder: (_) => const _MetricDialog());
    if (values == null) return;
    final result = await HealthMetricService.createMetric(metricType: values['metricType']!, value: values['value']!, unit: values['unit']!, notes: values['notes']);
    if (!mounted) return;
    if (result['success'] == true) _load(); else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message']?.toString() ?? 'Failed to create metric')));
  }

  String _label(String type) => type.replaceAll('_', ' ').split(' ').map((part) => part.isEmpty ? part : '${part[0].toUpperCase()}${part.substring(1)}').join(' ');
  IconData _icon(String type) { switch (type) { case 'heart_rate': return Icons.favorite; case 'blood_pressure': return Icons.bloodtype; case 'oxygen_level': return Icons.air; case 'temperature': return Icons.thermostat; case 'weight': return Icons.scale; case 'steps': return Icons.directions_walk; default: return Icons.monitor_heart; } }

  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Health Monitoring'), actions: [IconButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.healthReports), icon: const Icon(Icons.assessment))]), floatingActionButton: FloatingActionButton(onPressed: _add, child: const Icon(Icons.add)), body: SafeArea(child: _body()));

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), const SizedBox(height: AppSpacing.md), ElevatedButton(onPressed: _load, child: const Text('Retry'))]));
    return RefreshIndicator(onRefresh: _load, child: ListView(padding: const EdgeInsets.all(AppSpacing.lg), children: [
      Card(color: AppColors.warningOrange.withValues(alpha: 0.1), child: const Padding(padding: EdgeInsets.all(AppSpacing.md), child: Text('These values are for personal tracking only. Consult a qualified medical professional for medical interpretation.'))),
      const SizedBox(height: AppSpacing.lg),
      Text('Recorded Metrics', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: AppSpacing.md),
      if (_metrics.isEmpty) const Padding(padding: EdgeInsets.all(AppSpacing.xl), child: Center(child: Text('No health metrics recorded yet.'))),
      ..._metrics.map((metric) => Card(child: ListTile(leading: Icon(_icon(metric.metricType), color: AppColors.primaryBlue), title: Text(_label(metric.metricType)), subtitle: Text('${metric.recordedAt.toLocal()}\n${metric.notes ?? ''}'), isThreeLine: metric.notes != null, trailing: Text('${metric.value} ${metric.unit}'), onTap: () => Navigator.pushNamed(context, AppRoutes.healthMetricDetails, arguments: {'metric': metric}).then((_) => _load())))),
      const SizedBox(height: AppSpacing.lg),
      ListTile(leading: const Icon(Icons.directions_walk), title: const Text('Activity'), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () => Navigator.pushNamed(context, AppRoutes.healthActivity)),
      ListTile(leading: const Icon(Icons.history), title: const Text('Health History'), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () => Navigator.pushNamed(context, AppRoutes.healthHistory)),
    ]));
  }
}

class _MetricDialog extends StatefulWidget { const _MetricDialog(); @override State<_MetricDialog> createState() => _MetricDialogState(); }
class _MetricDialogState extends State<_MetricDialog> {
  final _value = TextEditingController(); final _unit = TextEditingController(); final _notes = TextEditingController(); String _type = 'heart_rate';
  @override void dispose() { _value.dispose(); _unit.dispose(); _notes.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => AlertDialog(title: const Text('Add Health Metric'), content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [DropdownButtonFormField<String>(initialValue: _type, items: const ['heart_rate', 'blood_pressure', 'blood_sugar', 'temperature', 'oxygen_level', 'weight', 'steps', 'sleep', 'water_intake', 'calories', 'general'].map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(), onChanged: (value) => setState(() => _type = value ?? 'general')), TextField(controller: _value, decoration: const InputDecoration(labelText: 'Value *')), TextField(controller: _unit, decoration: const InputDecoration(labelText: 'Unit *')), TextField(controller: _notes, decoration: const InputDecoration(labelText: 'Notes'))])), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), ElevatedButton(onPressed: _value.text.trim().isEmpty || _unit.text.trim().isEmpty ? null : () => Navigator.pop(context, {'metricType': _type, 'value': _value.text.trim(), 'unit': _unit.text.trim(), 'notes': _notes.text.trim()}), child: const Text('Save'))]);
}
