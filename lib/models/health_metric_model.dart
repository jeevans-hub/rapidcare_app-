class HealthMetric {
  final String id;
  final String metricType;
  final String value;
  final String unit;
  final DateTime recordedAt;
  final String? notes;
  final String source;

  const HealthMetric({required this.id, required this.metricType, required this.value, required this.unit, required this.recordedAt, this.notes, this.source = 'manual'});

  factory HealthMetric.fromJson(Map<String, dynamic> json) => HealthMetric(
        id: (json['_id'] ?? json['id'] ?? '').toString(),
        metricType: json['metricType']?.toString() ?? 'general',
        value: json['value']?.toString() ?? '',
        unit: json['unit']?.toString() ?? '',
        recordedAt: DateTime.tryParse(json['recordedAt']?.toString() ?? '') ?? DateTime.now(),
        notes: json['notes']?.toString(),
        source: json['source']?.toString() ?? 'manual',
      );

  Map<String, dynamic> toJson() => {'metricType': metricType, 'value': value, 'unit': unit, 'recordedAt': recordedAt.toIso8601String(), 'notes': notes, 'source': source};
}
