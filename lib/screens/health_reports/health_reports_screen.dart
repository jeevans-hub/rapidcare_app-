import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/health_summary_model.dart';
import '../../services/health_metric_service.dart';
import '../../widgets/health_reports/health_reports_widgets.dart';

class HealthReportsScreen extends StatefulWidget {
  const HealthReportsScreen({super.key});
  @override
  State<HealthReportsScreen> createState() => _HealthReportsScreenState();
}

class _HealthReportsScreenState extends State<HealthReportsScreen> {
  HealthSummary? _summary;
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
    final result = await HealthMetricService.getSummary();
    if (!mounted) return;
    if (result['success'] == true) {
      final data = result['data'];
      if (data is Map) {
        setState(() {
          _summary = HealthSummary.fromJson(Map<String, dynamic>.from(data));
          _loading = false;
        });
      }
    } else {
      setState(() {
        _error =
            result['message']?.toString() ?? 'Failed to fetch health summary';
        _loading = false;
      });
    }
  }

  String _value(dynamic metric) =>
      metric == null ? 'Not recorded' : '${metric.value} ${metric.unit}';
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Health Reports')),
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
    final summary = _summary!;
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const Text(
            'These summaries are for personal tracking only. Consult a qualified medical professional for medical interpretation.',
          ),
          const SizedBox(height: AppSpacing.lg),
          HealthReportInfoCard(
            icon: Icons.assessment,
            title: 'Recorded Metrics',
            content: '${summary.totalMetrics} health metrics recorded.',
          ),
          const SizedBox(height: AppSpacing.md),
          HealthReportInfoCard(
            icon: Icons.favorite,
            title: 'Latest Heart Rate',
            content: _value(summary.latestHeartRate),
          ),
          const SizedBox(height: AppSpacing.md),
          HealthReportInfoCard(
            icon: Icons.bloodtype,
            title: 'Latest Blood Pressure',
            content: _value(summary.latestBloodPressure),
          ),
          const SizedBox(height: AppSpacing.md),
          HealthReportInfoCard(
            icon: Icons.scale,
            title: 'Latest Weight',
            content: _value(summary.latestWeight),
          ),
          const SizedBox(height: AppSpacing.lg),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Analytics'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.healthReportAnalytics),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Health History'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, AppRoutes.healthHistory),
          ),
        ],
      ),
    );
  }
}
