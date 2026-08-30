import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/health_summary_model.dart';
import '../../services/health_metric_service.dart';

class HealthReportAnalyticsScreen extends StatefulWidget { const HealthReportAnalyticsScreen({super.key}); @override State<HealthReportAnalyticsScreen> createState() => _HealthReportAnalyticsScreenState(); }
class _HealthReportAnalyticsScreenState extends State<HealthReportAnalyticsScreen> {
  HealthSummary? _summary; bool _loading = true; String? _error;
  @override void initState() { super.initState(); _load(); }
  Future<void> _load() async { final result = await HealthMetricService.getSummary(); if (!mounted) return; if (result['success'] == true && result['data'] is Map) setState(() { _summary = HealthSummary.fromJson(Map<String, dynamic>.from(result['data'] as Map)); _loading = false; }); else setState(() { _error = result['message']?.toString() ?? 'Failed to fetch analytics'; _loading = false; }); }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Analytics')), body: SafeArea(child: _body()));
  Widget _body() { if (_loading) return const Center(child: CircularProgressIndicator()); if (_error != null) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), ElevatedButton(onPressed: _load, child: const Text('Retry'))])); final summary = _summary!; final entries = summary.metricCountsByType.entries.toList(); return RefreshIndicator(onRefresh: _load, child: ListView(padding: const EdgeInsets.all(AppSpacing.lg), children: [const Text('These summaries are for personal tracking only. Consult a qualified medical professional for medical interpretation.'), const SizedBox(height: AppSpacing.lg), Text('Metrics by type', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: AppSpacing.md), if (entries.isEmpty) const Padding(padding: EdgeInsets.all(AppSpacing.xl), child: Center(child: Text('No data available for analytics.'))), ...entries.map((entry) => Card(child: ListTile(title: Text(entry.key.replaceAll('_', ' ')), trailing: Text('${entry.value} records'))))])); }
}
