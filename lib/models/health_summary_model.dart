import 'health_metric_model.dart';

class HealthSummary {
  final int totalMetrics;
  final HealthMetric? latestHeartRate;
  final HealthMetric? latestBloodPressure;
  final HealthMetric? latestWeight;
  final List<HealthMetric> recentMetrics;
  final Map<String, int> metricCountsByType;

  const HealthSummary({required this.totalMetrics, this.latestHeartRate, this.latestBloodPressure, this.latestWeight, required this.recentMetrics, required this.metricCountsByType});

  factory HealthSummary.fromJson(Map<String, dynamic> json) {
    HealthMetric? metric(dynamic value) => value is Map ? HealthMetric.fromJson(Map<String, dynamic>.from(value)) : null;
    final recent = json['recentMetrics'] as List? ?? [];
    final counts = json['metricCountsByType'] as Map? ?? {};
    return HealthSummary(totalMetrics: int.tryParse(json['totalMetrics']?.toString() ?? '') ?? 0, latestHeartRate: metric(json['latestHeartRate']), latestBloodPressure: metric(json['latestBloodPressure']), latestWeight: metric(json['latestWeight']), recentMetrics: recent.whereType<Map>().map((item) => HealthMetric.fromJson(Map<String, dynamic>.from(item))).toList(), metricCountsByType: counts.map((key, value) => MapEntry(key.toString(), int.tryParse(value.toString()) ?? 0)));
  }
}
